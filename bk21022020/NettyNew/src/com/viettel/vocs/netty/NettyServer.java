/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.viettel.vocs.netty;

import io.netty.bootstrap.ServerBootstrap;
import io.netty.buffer.PooledByteBufAllocator;
import io.netty.channel.Channel;
import io.netty.channel.ChannelFuture;
import io.netty.channel.ChannelInboundHandlerAdapter;
import io.netty.channel.ChannelInitializer;
import io.netty.channel.ChannelOption;
import io.netty.channel.EventLoopGroup;
import io.netty.channel.FixedRecvByteBufAllocator;
import io.netty.channel.nio.NioEventLoopGroup;
import io.netty.channel.socket.SocketChannel;
import io.netty.channel.socket.nio.NioServerSocketChannel;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicLong;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author vttek
 */
public class NettyServer extends ChannelInboundHandlerAdapter {

    private final int port;

    public NettyServer(int port) {
        this.port = port;
    }

    public static AtomicLong nextIndex = new AtomicLong();
    public final static List<Channel> listChannel = new ArrayList<>();
    public static final OcsQueue<MsgObject> queue = new OcsQueue(10000);

    public static Channel getChannel() {
        long l = nextIndex.incrementAndGet();
        l = l % listChannel.size();
        return listChannel.get((int) l);
    }
    public static Thread sendThread = new Thread(new Runnable() {
        @Override
        public void run() {
            while (true) {
                try {
                    List<MsgObject> l = queue.dequeueList(100);
                    if (!l.isEmpty()) {
                        for (MsgObject o : l) {
                            System.out.println(".run()" + queue.size());
                            Channel c = getChannel();
                            c.write(o);
                        }
                    }
                } catch (InterruptedException ex) {
                    Logger.getLogger(NettyServer.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
    });

    public static ServerBootstrap bootstrap;
    public static Thread restartThread = new Thread(new Runnable() {
        @Override
        public void run() {
            while (true) {

            }
        }

    });

    public void run() throws InterruptedException {
        // Configure the server.
        // 200 threads max, Memory limitation: 1MB by channel, 1GB global, 100 ms of timeout  

        EventLoopGroup bossGroup = new NioEventLoopGroup();
        EventLoopGroup workerGroup = new NioEventLoopGroup();
        try {

            ServerBootstrap b = new ServerBootstrap(); // (2)
            b.group(bossGroup, workerGroup)
                    .localAddress(port)
                    .channel(NioServerSocketChannel.class) // (3)
                    .childHandler(new ChannelInitializer<SocketChannel>() { // (4)
                        @Override
                        public void initChannel(SocketChannel ch) throws Exception {
                            ch.config().setRecvByteBufAllocator(new FixedRecvByteBufAllocator(1048576));
                            ch.pipeline().addLast("ENCODER", new MsgObjectEncoder());
                            ch.pipeline().addLast("DECODER", new MsgObjectDecoder());

                            ch.pipeline().addLast("SERVER", new ServerHandler());
                        }
                    });

            wir
            b.option(ChannelOption.WRITE_BUFFER_WATER_MARK, 1048576);
            b.option(ChannelOption.WRITE_BUFFER_LOW_WATER_MARK, 1048576 / 2);
            // b.option(ChannelOption.TCP_NODELAY, true);
            b.option(ChannelOption.SO_RCVBUF, 1048576);
            // b.option(ChannelOption.SO_SNDBUF, 1048576);
            b.childOption(ChannelOption.TCP_NODELAY, true);
            b.childOption(ChannelOption.SO_RCVBUF, 1048576);
            b.childOption(ChannelOption.SO_SNDBUF, 1048576);
            b.childOption(ChannelOption.ALLOCATOR, PooledByteBufAllocator.DEFAULT);
            b.option(ChannelOption.ALLOCATOR, PooledByteBufAllocator.DEFAULT);
            ChannelFuture f = b.bind(port);
            //   f.channel().closeFuture().sync();

        } finally {
//            try {
//                bossGroup.shutdownGracefully().sync();
//            } catch (InterruptedException ex) {
//                Logger.getLogger(TimeServer.class.getName()).log(Level.SEVERE, null, ex);
//            }
        }

    }

    public static void main(String[] args) throws Exception {
     ResourceLeakDetector.setLevel(ResourceLeakDetector.Level.ADVANCED);    // Bat len de kiem tra he thong co bi leak mem ko
        System.out.println("laNettyServer___v1");
        int port;
        if (args.length > 0) {
            port = Integer.parseInt(args[0]);
        } else {
            port = 8080;
        }
        System.out.println("Runnetty serrver at port " + port);
        new NettyServer(port).run();
    }

}
