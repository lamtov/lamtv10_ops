/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.viettel.vocs.netty;

/**
 *
 * @author thuanlk
 */
public class Utils {

    public static byte[] intToByteArray(int n) {
        byte[] res = new byte[4];
        res[0] = ((byte) (n & 0xFF));
        n >>>= 8;
        res[1] = ((byte) (n & 0xFF));
        n >>>= 8;
        res[2] = ((byte) (n & 0xFF));
        n >>>= 8;
        res[3] = ((byte) (n & 0xFF));
        return res;
    }

    public static int byteArrayToInt(byte[] b, int offset) {
        int res = b[(0 + offset)] & 0xFF | (b[(1 + offset)] & 0xFF) << 8 | (b[(2 + offset)] & 0xFF) << 16 | (b[(3 + offset)] & 0xFF) << 24;
        return res;
    }
}
