/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package demo;

import org.eclipse.jetty.http2.client.HTTP2Client;
import org.eclipse.jetty.util.ssl.SslContextFactory;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeUnit;
import org.eclipse.jetty.client.HttpClient;
import org.eclipse.jetty.client.api.ContentResponse;
import org.eclipse.jetty.client.util.BytesContentProvider;
import org.eclipse.jetty.http.HttpMethod;
import org.eclipse.jetty.http2.client.http.HttpClientTransportOverHTTP2;
import org.eclipse.jetty.util.thread.QueuedThreadPool;

public class SendLowLevelClient {

    public static void main(String[] args) throws Exception {
        //init_tps_calculate
        long startSend = System.currentTimeMillis();
        final Statistic st = new Statistic("REST");
        int threadTimeOut = Integer.getInteger("threadTimeOut", 100000000);
        int isLog = Integer.getInteger("isLog", 0);
        int numberThread = Integer.getInteger("numberThread", 1);
        int poolSize = Integer.getInteger("poolSize", 1);
        int msgSize = Integer.getInteger("msgSize", 2000);
        int maxConcurrentPushedStream = Integer.getInteger("maxConcurrentPushedStream", 32);
        int maxConnectionsPerDestination = Integer.getInteger("maxConnectionsPerDestination", 200);
        int maxRequestsQueuedPerDestination = Integer.getInteger("maxRequestsQueuedPerDestination", 1000);

        int selectors = Integer.getInteger("selectors", 1);
        int sessionRecvWindow = Integer.getInteger("sessionRecvWindow", 16 * 1024 * 1024);
        int streamRecvWindow = Integer.getInteger("streamRecvWindow", 16 * 1024 * 1024);

        int pipeliningLimit = Integer.getInteger("pipeLine", 1);
        String host = System.getProperty("host", "jetty");
        String port = System.getProperty("port", "8443");
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < msgSize; i++) {
            sb.append("x");
        }
        String content = sb.toString();
        // Create and start HTTP2Client.

        // Prepare the HTTP request headers.
        //HttpFields requestFields = new HttpFields();
        //requestFields.put("User-Agent", client.getClass().getName() + "/" + Jetty.VERSION);
        // Prepare the listener to receive the HTTP response frames.
        // Use the Stream object to send request content, if any, using a DATA frame.
        List<HttpClient> listHttpClient = new ArrayList<HttpClient>();
        for (int p = 0; p < poolSize; p++) {
            System.out.println("p + " + p);
            HTTP2Client http2Client = new HTTP2Client();

            http2Client.setConnectTimeout(300);
            http2Client.setIdleTimeout(50);
            http2Client.setInitialSessionRecvWindow(sessionRecvWindow);
            http2Client.setInitialStreamRecvWindow(streamRecvWindow);
            http2Client.setSelectors(selectors);
            http2Client.setMaxConcurrentPushedStreams(maxConcurrentPushedStream);
  
            
            
            
            SslContextFactory sslContextFactory = new SslContextFactory(true);
            HttpClient httpClient = new org.eclipse.jetty.client.HttpClient(new HttpClientTransportOverHTTP2(http2Client), sslContextFactory);
            httpClient.setMaxConnectionsPerDestination(maxConnectionsPerDestination);
            httpClient.setMaxRequestsQueuedPerDestination(maxRequestsQueuedPerDestination);
            httpClient.setTCPNoDelay(true);
//            httpClient.setExecutor(http2Client.getExecutor());
            httpClient.setScheduler(http2Client.getScheduler());
            httpClient.setByteBufferPool(http2Client.getByteBufferPool());
            httpClient.setConnectTimeout(http2Client.getConnectTimeout());
            httpClient.setIdleTimeout(http2Client.getIdleTimeout());
            //httpClient.setResponseBufferSize(poolSize);
            //httpClient.setRequestBufferSize(selectors);
            
            
          
            
            
            int maxThreads = 10000;
            int minThreads = 10;
            int idleTimeout = 120;

            QueuedThreadPool threadPool = new QueuedThreadPool(maxThreads, minThreads, idleTimeout);
            //httpClient.start();
           // httpClient.setExecutor(threadPool);
            httpClient.addBean(sslContextFactory);
            httpClient.start();
            listHttpClient.add(httpClient);
        }
        List<Thread> listThread = new ArrayList<>();
        for (int i = 0; i < numberThread; i++) {
            final int x = i;
            Thread t = new Thread(new Runnable() {

                @Override
                public void run() {
                    try {
                        boolean stopSend = false;
                        while (!stopSend) {
                            //for (int j = 0; j < 40; j++) {

                            long start = System.currentTimeMillis();
                            // Prepare the HTTP request object.
                            //System.err.println("sdfsdfsdfsf");
                            org.eclipse.jetty.client.api.Request request = listHttpClient.get(x % poolSize).newRequest("https://" + host + ":" + port);
                            request.method(HttpMethod.POST);
                            request.timeout(5, TimeUnit.SECONDS);
                            //request.header(HttpHeader.CONTENT_TYPE, "text/plain");
                            request.content(new BytesContentProvider(content.getBytes()));

                            ContentResponse response = request.send();
//                           System.out.println(responseContent.toString());
                            long resTime = System.currentTimeMillis() - start;
                            st.update(resTime);
                            if (start - startSend > threadTimeOut) {
                                //System.out.println("????????????????????????????");
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
        for (HttpClient t : listHttpClient) {
            t.stop();
        }

    }
}
