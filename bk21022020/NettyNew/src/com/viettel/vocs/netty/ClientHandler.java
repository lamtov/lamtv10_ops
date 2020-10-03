/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.viettel.vocs.netty;

import com.viettel.vocs.test.Statistic;
import io.netty.channel.ChannelHandlerContext;
import io.netty.channel.ChannelInboundHandlerAdapter;
import io.netty.util.ReferenceCountUtil;
import java.util.concurrent.atomic.AtomicLong;

/**
 *
 * @author tovan
 */
public class ClientHandler extends ChannelInboundHandlerAdapter {

    private final AtomicLong transferredMessages = new AtomicLong();

    private static Statistic st = new Statistic("NETTY");
                
     int isOneSize = Integer.getInteger("oneSize", 0);

    @Override
    public void channelRead(ChannelHandlerContext ctx, Object msg) {
        if (msg instanceof MsgObject) {
            try {

                MsgObject msgO = (MsgObject) msg;

                long restime = System.currentTimeMillis() - msgO.getStartTime();

                st.update(restime);
                ReferenceCountUtil.release(msgO);

            } catch (Exception ex) {
                ex.printStackTrace();
            } finally {
                ReferenceCountUtil.release(msg);
                /*Su dung ReferenceCountUtil.release(msg); tai moi ham channelRead;*/
            }
        }
    }

    @Override
    public void exceptionCaught(ChannelHandlerContext ctx, Throwable cause) {
        cause.printStackTrace();
        ctx.close();
    }
}
