/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.viettel.vocs.netty;

import com.viettel.vocs.test.Statistic;
import io.netty.bootstrap.Bootstrap;
import io.netty.buffer.PooledByteBufAllocator;
import io.netty.channel.Channel;
import io.netty.channel.ChannelFuture;
import io.netty.channel.ChannelInitializer;
import io.netty.channel.ChannelOption;
import io.netty.channel.EventLoopGroup;
import io.netty.channel.nio.NioEventLoopGroup;
import io.netty.channel.socket.SocketChannel;
import io.netty.channel.socket.nio.NioSocketChannel;

/**
 *
 * @author thuanlk
 */
public class NettyClient {

    private final String host;
    private final int port;

    private ChannelFuture f;
    int isOneSize = Integer.getInteger("oneSize", 0);
    private static Statistic st = new Statistic("NETTY");

    public ChannelFuture getChannel() {
        return f;
    }

    public NettyClient(String host, int port) {
        this.host = host;
        this.port = port;
    }

    public void run() throws InterruptedException {

        EventLoopGroup workerGroup = new NioEventLoopGroup();

        try {
            Bootstrap b = new Bootstrap();
            b.group(workerGroup).channel(NioSocketChannel.class)
                    //   .remoteAddress(new InetSocketAddress(host, port))
                    .handler(new ChannelInitializer<SocketChannel>() {
                        @Override
                        protected void initChannel(SocketChannel ch) throws Exception {
                            ch.pipeline().addLast("ENCODER", new MsgObjectEncoder());
                            ch.pipeline().addLast("DECODER", new MsgObjectDecoder());
                            ch.pipeline().addLast("CLIENT", new ClientHandler());

                        }
                    ;

            });
      
//           
//            f.channel().closeFuture().sync();
            b.option(ChannelOption.WRITE_BUFFER_HIGH_WATER_MARK, 1048576);
            b.option(ChannelOption.WRITE_BUFFER_LOW_WATER_MARK, 1048576 / 2);

            b.option(ChannelOption.SO_RCVBUF, 1048576);

            b.option(ChannelOption.TCP_NODELAY, true);

            b.option(ChannelOption.SO_SNDBUF, 1048576);
            b.option(ChannelOption.ALLOCATOR, PooledByteBufAllocator.DEFAULT);
            f = b.connect(host, port);
        } finally {
            //workerGroup.shutdownGracefully().sync();
        }

    }

    public void send(MsgObject msg) {
        Channel channel = f.channel();
        if (channel != null && channel.isActive()) {
            channel.writeAndFlush(msg);

            if (isOneSize != 0) {
                long restime = System.currentTimeMillis() - msg.getStartTime();

                st.update(restime);
            }

            //System.out.println("com.viettel.vocs.netty.NettyClient.send()");
        } else {
            //  System.out.println("com.viettel.vocs.netty.NettyClient.send()" + "NOTOK");
        }
    }

}
