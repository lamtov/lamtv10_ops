/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package test;

import java.util.ArrayList;
import java.util.List;
import org.eclipse.jetty.client.HttpClient;
import org.eclipse.jetty.client.api.ContentResponse;
import org.eclipse.jetty.client.util.BytesContentProvider;
import org.eclipse.jetty.http.HttpHeader;
import org.eclipse.jetty.http2.client.HTTP2Client;
import org.eclipse.jetty.http2.client.http.HttpClientTransportOverHTTP2;
import org.eclipse.jetty.util.ssl.SslContextFactory;

/**
 *
 * @author vttek
 */
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
import org.eclipse.jetty.client.HttpClient;
import org.eclipse.jetty.client.api.ContentResponse;
import org.eclipse.jetty.client.api.Response;
import org.eclipse.jetty.client.api.Result;
import org.eclipse.jetty.client.util.BufferingResponseListener;
import org.eclipse.jetty.client.util.BytesContentProvider;
import org.eclipse.jetty.client.util.StringContentProvider;
import org.eclipse.jetty.http.HttpHeader;
import org.eclipse.jetty.http.HttpMethod;
import org.eclipse.jetty.http2.client.http.HttpClientTransportOverHTTP2;

public class SendAsyncClient {

    public static void main(String[] args) throws Exception {
        //init_tps_calculate
        long startSend = System.currentTimeMillis();
        final Statistic st = new Statistic("REST");
        int threadTimeOut = Integer.getInteger("threadTimeOut", 100000000);
        int isLog = Integer.getInteger("isLog", 0);
        int numberThread = Integer.getInteger("numberThread", 1);
        int msgSize = Integer.getInteger("msgSize", 300);
        int maxOpenRequest = Integer.getInteger("maxOpenRequest", 32);
        int pipeliningLimit = Integer.getInteger("pipeLine", 1);
        String host = System.getProperty("host", "jetty");
        String port = System.getProperty("port", "8443");
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < msgSize; i++) {
            sb.append("x");
        }
        String content = sb.toString();
        // Create and start HTTP2Client.
        HTTP2Client http2Client = new HTTP2Client();

        http2Client.setConnectTimeout(300);
        http2Client.setIdleTimeout(50);
        SslContextFactory sslContextFactory = new SslContextFactory(true);
        HttpClient httpClient = new org.eclipse.jetty.client.HttpClient(new HttpClientTransportOverHTTP2(http2Client), sslContextFactory);
        httpClient.setMaxConnectionsPerDestination(2000);
        httpClient.setMaxRequestsQueuedPerDestination(10000);

        //httpClient.start();
        httpClient.addBean(sslContextFactory);
        httpClient.start();

        // Prepare the HTTP request headers.
        //HttpFields requestFields = new HttpFields();
        //requestFields.put("User-Agent", client.getClass().getName() + "/" + Jetty.VERSION);
        // Prepare the listener to receive the HTTP response frames.
        // Use the Stream object to send request content, if any, using a DATA frame.
        List<Thread> listThread = new ArrayList<>();
        for (int i = 0; i < numberThread; i++) {
            Thread t = new Thread(new Runnable() {
                @Override
                public void run() {
                    try {
                        boolean stopSend = false;
//                        while (!stopSend) {
                        for (int j = 0; j < 20; j++) {

                            long start = System.currentTimeMillis();

                            System.err.println("sdfsdfsdfsf");
                            org.eclipse.jetty.client.api.Request request = httpClient.newRequest("https://" + host + ":" + port);
                            request.method(HttpMethod.POST);
                            request.version(HttpVersion.HTTP_2);
                            request.header(HttpHeader.CONTENT_TYPE, "text/plain");
                            request.content(new BytesContentProvider(content.getBytes()));
//                            request.send(new BufferingResponseListener(8 * 1024 * 1024) {
//                                @Override
//                                public void onComplete(Result result) {
//                                    if (!result.isFailed()) {
//                                        System.err.println("xxxx");
//                                        byte[] responseContent = getContent();
//                                        System.out.println(responseContent.toString());
//                                        // Your logic here
//                                    }
//                                }
//                            });

//                            request.onRequestQueued(req -> {
//                                System.out.println("" + req);
//                            }).onRequestQueued(reqq -> {
//                                System.out.println("" + reqq);
//                            })
//                                    .onRequestBegin(reqqq -> {
//                                        System.out.println("reqqq" + reqqq);
//                                    })
//                                    .onResponseBegin(response -> {
//                                        System.out.println("response" + response);
//                                    })
//                                    .onResponseHeaders(response -> {
//                                    })
//                                    .onResponseContent((response, buffer) -> {
//                                    })
//                                    .send();
                            request.send(new Response.CompleteListener() {
                                @Override
                                public void onComplete(Result result) {
                                    System.out.println("COMPLETE" + result);
                                }
                            });
                            //request.send();
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
        httpClient.stop();

    }
}
