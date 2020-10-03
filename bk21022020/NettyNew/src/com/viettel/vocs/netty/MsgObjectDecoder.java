/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.viettel.vocs.netty;

import io.netty.buffer.ByteBuf;
import io.netty.channel.ChannelHandlerContext;
import io.netty.handler.codec.ReplayingDecoder;
import io.netty.util.ReferenceCountUtil;
import java.util.List;

/**
 *
 * @author vttek
 */
public class MsgObjectDecoder extends ReplayingDecoder<MyDecoderState> {

    public MsgObjectDecoder() {
        super(MyDecoderState.READ_LENGTH);
    }
    private int length;

    @Override
    protected void decode(ChannelHandlerContext chc, ByteBuf in, List<Object> out) throws Exception {

        switch (state()) {
            case READ_LENGTH:
                length = in.readInt();
                checkpoint(MyDecoderState.READ_CONTENT);
            case READ_CONTENT:
                byte[] bytes = new byte[length];

                in.readBytes(bytes);

                MsgObject msg = MsgObject.decode(bytes);
                checkpoint(MyDecoderState.READ_LENGTH);
                
                out.add(msg);
                ReferenceCountUtil.release(msg);
                break;
            default:
                throw new Error("Shouldn't reach here");

                
        }
    }

}
