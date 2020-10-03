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
import org.eclipse.jetty.util.FuturePromise;
import org.eclipse.jetty.util.Jetty;
import org.eclipse.jetty.util.ssl.SslContextFactory;
import java.net.InetSocketAddress;
import java.nio.ByteBuffer;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.TimeoutException;
import org.eclipse.jetty.http2.frames.PushPromiseFrame;
import org.eclipse.jetty.util.Callback;
import org.eclipse.jetty.util.Promise;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

/**
 *
 * @author vttek
 */
public class ExamplewithDataFrame {

    public static void main(String[] args) throws Exception {
        // Create and start HTTP2Client.
        HTTP2Client client = new HTTP2Client();

        client.setConnectTimeout(30);
        client.setIdleTimeout(5);
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

        // Prepare the HTTP request object.
        // Prepare the listener to receive the HTTP response frames.
        // Use the Stream object to send request content, if any, using a DATA frame.
        for (int i = 0; i < 1; i++) {
            sendData(host, port, client, session);
        }
        // When done, stop the client.
        client.stop();

    }

    public static void sendData(String host, int port, HTTP2Client client, Session session) throws InterruptedException, ExecutionException, TimeoutException {
        System.out.println("i ");
        // Prepare the HTTP request headers.
        HttpFields requestFields = new HttpFields();
        requestFields.put("User-Agent", client.getClass().getName() + "/" + Jetty.VERSION);
        MetaData.Request request = new MetaData.Request("POST", new HttpURI("https://" + host + ":" + port + "/data"), HttpVersion.HTTP_2, requestFields);
        // Create the HTTP/2 HEADERS frame representing the HTTP request.
        HeadersFrame headersFrame = new HeadersFrame(1, request, null, false);

        PrintingFramesHandler responseListener = new PrintingFramesHandler();
        // Send the HEADERS frame to create a stream.

        //System.out.println(i);
        // session.newStream(headersFrame, streamPromise, responseListener);
        //CountDownLatch latch = new CountDownLatch(1);
        FuturePromise<Stream> streamPromise = new FuturePromise<>();
        session.newStream(headersFrame, streamPromise, new Stream.Listener.Adapter() {

            @Override
            public void onHeaders(Stream stream, HeadersFrame frame) {
                System.out.println("[" + frame.getStreamId() + "] HEADERS " + frame.getMetaData().toString());
                frame.getMetaData().getFields().forEach(field -> System.out.println("[" + stream.getId() + "]     " + field.getName() + ": " + field.getValue()));
            }

            @Override
            public void onData(Stream stream, DataFrame frame, Callback callback) {
                byte[] bytes = new byte[frame.getData().remaining()];
                frame.getData().get(bytes);
                System.out.println("[" + frame.getStreamId() + "] DATA " + new String(bytes));
                callback.succeeded();

                if (frame.isEndStream()) {
                    System.out.println("OH NO");

                }
            }
        });
        //session.newStream(headersFrame, streamPromise, responseListener);
        Stream str = streamPromise.get(5, TimeUnit.SECONDS);

        ByteBuffer content = ByteBuffer.wrap(("tovanlam").getBytes());
        DataFrame requestContent = new DataFrame(str.getId(), content, true);
        //DataCallBack dataCallback = new DataCallBack();
        str.data(requestContent, Callback.NOOP);
       // latch.await(5, TimeUnit.SECONDS);
    }
}
