/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.viettel.vocs.netty;

import io.netty.buffer.ByteBuf;
import io.netty.buffer.PooledByteBufAllocator;
import io.netty.buffer.Unpooled;
import java.io.Serializable;
import java.nio.ByteBuffer;

/**
 *
 * @author thuanlk
 */
public class MsgObject implements Serializable {

    public static final long serialVersionUID = 8483092915955248121l;
    byte[] data;
    long startTime;

    public byte[] getData() {
        return data;
    }

    public long getStartTime() {
        return startTime;
    }

    public void setData(byte[] data) {
        this.data = data;
    }

    public void setStartTime(long startTime) {
        this.startTime = startTime;
    }

    public MsgObject(byte[] data, long startTime) {
        this.data = data;
        this.startTime = startTime;
    }

    public static MsgObject decode(byte[] data) {
//        ByteBuffer buff = ByteBuffer.wrap(data);
//        if (buff != null) {
//            long time = buff.getLong();
//            byte[] array = new byte[data.length - 8];
//            buff.get(array);
//            return new MsgObject(array, time);
//        }
//        return null;

        ByteBuf buff = Unpooled.wrappedBuffer(data);
        if (buff != null) {
            long time = buff.readLong();
            byte[] array = new byte[data.length - 8];
            buff.readBytes(array);
            buff.release();
            return new MsgObject(array, time);
//        ByteBuffer buff = ByteBuffer.wrap(data);
//        if (buff != null) {
//            long time = buff.getLong();
//            byte[] array = new byte[data.length - 8];
//            buff.get(array);
//            return new MsgObject(array, time);
        }
        return null;

    }

    public byte[] encode() {

        int totalLen = data.length + 8;
        ByteBuf buf = PooledByteBufAllocator.DEFAULT.buffer();

        buf.writeInt(totalLen);
        buf.writeLong(startTime);
        buf.writeBytes(data);
        byte[] bytes = new byte[buf.readableBytes()];
        buf.readBytes(bytes);
        buf.release();
        /* Khi khoi tao ByteBuf thi release() tai cuoi ham*/
        return bytes;
    }

    @Override
    public String toString() {
        return "MsgObject{" + "data=" + new String(data) + ", startTime=" + startTime + '}';
    }

}
