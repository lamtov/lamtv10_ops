/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package server;


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
import org.eclipse.jetty.util.Promise;
import org.eclipse.jetty.util.ssl.SslContextFactory;
import java.net.InetSocketAddress;
import java.util.concurrent.TimeUnit;
/**
 *
 * @author vttek
 */
public class SSLClinetHttp2 {

    public static void main(String[] args) throws Exception {
        long startTime = System.nanoTime();

        // Create and start HTTP2Client.
        HTTP2Client client = new HTTP2Client();
        SslContextFactory sslContextFactory = new SslContextFactory(true);
        client.addBean(sslContextFactory);
        client.start();

        // Connect to host.
        String host = "jetty";
        int port = 8443;

        FuturePromise<Session> sessionPromise = new FuturePromise<>();
        client.connect(sslContextFactory, new InetSocketAddress(host, port), new ServerSessionListener.Adapter(), sessionPromise);

        // Obtain the client Session object.
        Session session = sessionPromise.get(5, TimeUnit.SECONDS);
    }
}
