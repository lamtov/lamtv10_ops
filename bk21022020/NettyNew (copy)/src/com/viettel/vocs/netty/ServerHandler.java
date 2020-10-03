/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.viettel.vocs.netty;

import io.netty.channel.ChannelHandlerContext;
import io.netty.channel.ChannelInboundHandlerAdapter;
import io.netty.util.ReferenceCountUtil;
import java.util.concurrent.atomic.AtomicLong;
import java.util.concurrent.locks.ReentrantLock;
import java.util.logging.Logger;

/**
 *
 * @author vttek
 */
public class ServerHandler extends ChannelInboundHandlerAdapter {


    private final Logger logger = Logger.getLogger(ServerHandler.class.getName());
    private static final AtomicLong count = new AtomicLong();

    private static long startTime = System.currentTimeMillis() - 1;
    private static long beginTime = System.currentTimeMillis() - 1;
    private static ReentrantLock lock = new ReentrantLock();

    int isOneSize = Integer.getInteger("oneSize", 0);
    //Mac dinh oneSize == 0 la co gui tra ve tu server , ==1 thi server ko phan hoi gi

    @Override
    public void channelRead(ChannelHandlerContext ctx, Object msg) {
       
        try {


            if (msg != null) {
                if (isOneSize == 0) {   
                    if (ctx.channel().isWritable()) {
                        MsgObject msgO = (MsgObject) msg;
                      
                        ctx.writeAndFlush(msgO);
                        ReferenceCountUtil.release(msgO);
                    } else {
                        //System.err.println("cannot write": + ctx.channel().);
                    }
                }

                long l = count.incrementAndGet();

                long current = System.currentTimeMillis();
                if (current - startTime > 5000) {
                    lock.lock();
                    try {
                        if (current - startTime > 5000) {
                            long tps = l * 1000 / (current - startTime);
                            System.out.println("Current TPS: " + tps);
                            startTime = current;
                            count.set(0);
                            
                        }
                    } finally {
                        lock.unlock();
                    }
                }

                if (current - beginTime > 10000) {
                  
                }
            }

        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            ReferenceCountUtil.release(msg);

        }

    }

    @Override
    public void exceptionCaught(ChannelHandlerContext ctx, Throwable cause) {
        cause.printStackTrace();
        ctx.close();
    }

}
