/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.viettel.vocs.netty;

import io.netty.buffer.ByteBuf;
import io.netty.channel.ChannelHandlerContext;
import io.netty.handler.codec.MessageToByteEncoder;
import io.netty.util.ReferenceCountUtil;

/**
 *
 * @author vttek
 */
public class MsgObjectEncoder extends MessageToByteEncoder<MsgObject> {

    @Override
    protected void encode(ChannelHandlerContext chc, MsgObject in, ByteBuf bb) throws Exception {
           
            byte[] bytes = in.encode();
            
            
            
            if()
            bb.writeBytes(bytes);
             ReferenceCountUtil.release(in);
        

    }
}
