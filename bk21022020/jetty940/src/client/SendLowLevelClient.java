/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package client;

import org.eclipse.jetty.http.HttpFields;
import org.eclipse.jetty.http.HttpURI;
import org.eclipse.jetty.http.HttpVersion;
import org.eclipse.jetty.http.MetaData;
import org.eclipse.jetty.http2.api.Session;
import org.eclipse.jetty.http2.api.Stream;
import org.eclipse.jetty.http2.api.server.ServerSessionListener;
import org.eclipse.jetty.http2.client.HTTP2Client;
import org.eclipse.jetty.http2.frames.DataFrame;
import org.eclipse.jetty.http2.frames.HeadersFrame;
import org.eclipse.jetty.util.Callback;
import org.eclipse.jetty.util.FuturePromise;
import org.eclipse.jetty.util.Jetty;
import org.eclipse.jetty.util.ssl.SslContextFactory;
import java.net.InetSocketAddress;
import java.nio.ByteBuffer;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeUnit;

public class SendLowLevelClient {

    public static void main(String[] args) throws Exception {
        //init_tps_calculate
        long startSend = System.currentTimeMillis();
        final Statistic st = new Statistic("REST");
        int threadTimeOut = Integer.getInteger("threadTimeOut", 100000000);
        int isLog = Integer.getInteger("isLog", 0);
        int numberThread = Integer.getInteger("numberThread", 1);
        int msgSize = Integer.getInteger("msgSize", 2000);
        int maxOpenRequest = Integer.getInteger("maxOpenRequest", 32);
        int pipeliningLimit = Integer.getInteger("pipeLine", 1);
        String host = System.getProperty("host", "jetty");
        String port = System.getProperty("port", "8443");
        
        
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < msgSize; i++) {
            sb.append("x");
        }
        

        // Create and start HTTP2Client.
        HTTP2Client client = new HTTP2Client();
        SslContextFactory sslContextFactory = new SslContextFactory();
        client.addBean(sslContextFactory);

        client.start();
        FuturePromise<Session> sessionPromise = new FuturePromise<>();
        client.connect(sslContextFactory, new InetSocketAddress(host, Integer.parseInt(port)), new ServerSessionListener.Adapter(), sessionPromise);

        // Obtain the client Session object.
        Session session = sessionPromise.get(5, TimeUnit.SECONDS);

        // Prepare the HTTP request headers.
        HttpFields requestFields = new HttpFields();
        requestFields.put("User-Agent", client.getClass().getName() + "/" + Jetty.VERSION);

        // Prepare the listener to receive the HTTP response frames.
        // Use the Stream object to send request content, if any, using a DATA frame.
        List<Thread> listThread = new ArrayList<>();
        for (int i = 0; i < numberThread; i++) {
            Thread t = new Thread(new Runnable() {
                @Override
                public void run() {
                    try {
                        boolean stopSend = false;
                       while (!stopSend) {
                      //  for(int j=0;j<20000;j++){
                            
                            long start = System.currentTimeMillis();
                            // Prepare the HTTP request object.
                            MetaData.Request request = new MetaData.Request("POST", new HttpURI("https://" + host + ":" + port + "/"), HttpVersion.HTTP_2, requestFields);
                            // Create the HTTP/2 HEADERS frame representing the HTTP request.
                            HeadersFrame headersFrame = new HeadersFrame(1, request, null, false);
                            ResponseFramesHandler responseListener = new ResponseFramesHandler();
                            // Send the HEADERS frame to create a stream.
                            FuturePromise<Stream> streamPromise = new FuturePromise<>();
                            //System.out.println(i);
                            session.newStream(headersFrame, streamPromise, responseListener);

                            Stream stream = streamPromise.get(5, TimeUnit.SECONDS);
                            ByteBuffer content = ByteBuffer.wrap((sb.toString()).getBytes());
                            DataFrame requestContent = new DataFrame(stream.getId(), content, true);
                            stream.data(requestContent, Callback.NOOP);
                            responseListener.getCompletedFuture().get();
                            
                            
                            long resTime = System.currentTimeMillis() - start;
                            st.update(resTime);
                            if (start - startSend > threadTimeOut) {
                                System.out.println("????????????????????????????");
                                stopSend = true;
                           }

                        }
                    } catch (Exception ex) {
                        ex.printStackTrace();
                    }
                }

            });
            // When done, stop the client.
            listThread.add(t);
        }
        for (Thread t : listThread) {
            t.start();
        }

        for (Thread t : listThread) {
            t.join();
        }
        client.stop();

    }
}
