/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package test;

/*
 * Copyright (c) 2015 Gregor Roth
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
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
import org.eclipse.jetty.util.FuturePromise;
import org.eclipse.jetty.util.Jetty;
import org.eclipse.jetty.util.ssl.SslContextFactory;
import java.net.InetSocketAddress;
import java.nio.ByteBuffer;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.TimeoutException;
import org.eclipse.jetty.client.HttpClient;
import org.eclipse.jetty.client.api.ContentResponse;
import org.eclipse.jetty.client.util.StringContentProvider;
import org.eclipse.jetty.http.HttpHeader;
import org.eclipse.jetty.http.MetaData.Request;
import org.eclipse.jetty.http2.HTTP2Session;
import org.eclipse.jetty.http2.client.http.HttpClientTransportOverHTTP2;
import org.eclipse.jetty.http2.frames.PushPromiseFrame;
import org.eclipse.jetty.util.Callback;


@SuppressWarnings("serial")
public class HighLevelHttp2Client {

    public static void main(String[] args) throws Exception {
        
        HTTP2Client http2Client = new HTTP2Client();
        
        http2Client.setConnectTimeout(30);
        http2Client.setIdleTimeout(5);
        SslContextFactory sslContextFactory = new SslContextFactory(true);
        HttpClient httpClient = new org.eclipse.jetty.client.HttpClient(new HttpClientTransportOverHTTP2(http2Client), sslContextFactory);
        httpClient.setMaxConnectionsPerDestination(20);
        httpClient.setMaxRequestsQueuedPerDestination(100);
        
        httpClient.start();
        httpClient.addBean(sslContextFactory);
        httpClient.start();
        String host = "jetty";
        int port = 8443;
        for (int i = 0; i < 10000; i++) {
            org.eclipse.jetty.client.api.Request request = httpClient.POST( "https://" + host + ":" + port + "/data");
            request.header(HttpHeader.CONTENT_TYPE, "application/json");
            request.content(new StringContentProvider("xmlRequest PayLoad goes here" + i, "utf-8"));
            ContentResponse response = request.send();
            String res = new String(response.getContent());
            System.out.println("res "+ res);
        }
        httpClient.stop();
    }
}