/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.viettel.vocs.test;

import com.viettel.vocs.netty.MsgObject;
import com.viettel.vocs.netty.NettyClient;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author thuanlk
 */
public class SendNetty {

    public static void main(String[] args) throws InterruptedException {
        final String host = System.getProperty("host", "127.0.0.1");
        final int port = Integer.getInteger("port", 8080);
        int msgSize = Integer.getInteger("msgSize",2000);
        int numberThread = Integer.getInteger("numberThread", 1);

        System.out.println("host: " + host + " port: " + port + " msgSize: " + msgSize + " numberThread: " + numberThread);

        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < msgSize; i++) {
            sb.append("x");
        }
        final byte[] data = sb.toString().getBytes();
        final Statistic st = new Statistic("NETTYCLIENT");

        List<Thread> lst = new ArrayList<>();
        for (int i = 0; i < numberThread; i++) {
            Thread t = new Thread(new Runnable() {
                @Override
                public void run() {
                 //   System.out.println("lamtvsend");
                    NettyClient client = new NettyClient(host, port);
                    try {

                        client.run();

                    } catch (InterruptedException ex) {
                        ex.printStackTrace();

                    }

                    while (true) {
//
                        try {
                           Thread.sleep(1);
                        } catch (InterruptedException ex) {
                            Logger.getLogger(SendNetty.class.getName()).log(Level.SEVERE, null, ex);
                        }

                        MsgObject msg = new MsgObject(data, System.currentTimeMillis());
                        msg.setStartTime(System.currentTimeMillis());
                        client.send(msg);
                        st.countTPSSend();
//                        if(client.getChannel().isConnected()==false){
//                            break;
//                        }
                    }
                }
            });
            lst.add(t);
        }

        for (Thread t : lst) {
            t.start();
        }

    }
}
