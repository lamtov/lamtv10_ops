/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package testAsync;

import java.net.InetSocketAddress;
import java.nio.ByteBuffer;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.TimeoutException;
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
import org.eclipse.jetty.http2.frames.PushPromiseFrame;
import org.eclipse.jetty.util.Callback;
import org.eclipse.jetty.util.FuturePromise;
import org.eclipse.jetty.util.Jetty;
import org.eclipse.jetty.util.Promise;
import org.eclipse.jetty.util.ssl.SslContextFactory;
import server.DataCallBack;
import server.PrintingFramesHandler;

/**
 *
 * @author vttek
 */
public class SendAsyncClient {

    public static void main(String[] args) throws Exception {
        // Create and start HTTP2Client.
        HTTP2Client client = new HTTP2Client();

        client.setConnectTimeout(30000);
        client.setIdleTimeout(500);

        SslContextFactory sslContextFactory = new SslContextFactory(true);
        client.addBean(sslContextFactory);
        client.start();

        // Connect to host.
        String host = "jetty";
        int port = 8443;

        FuturePromise<Session> sessionPromise = new FuturePromise<>();
        client.connect(sslContextFactory, new InetSocketAddress(host, port), new ServerSessionListener.Adapter(), sessionPromise);
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < 2000; i++) {
            sb.append("x");
        }
        // Obtain the client Session object.
        Session session = sessionPromise.get(5, TimeUnit.SECONDS);
        String content = sb.toString();
        for (int i = 0; i < 1; i++) {
            sendData(host, port, client, session, i, content);
        }
        // When done, stop the client.
        client.stop();

    }

    public static void sendData(String host, int port, HTTP2Client client, Session session, int i, String content) throws InterruptedException, ExecutionException, TimeoutException {
        System.out.println("i " + i);
        // Prepare the HTTP request headers.
        HttpFields requestFields = new HttpFields();
        requestFields.put("User-Agent", client.getClass().getName() + "/" + Jetty.VERSION);
        MetaData.Request request = new MetaData.Request("POST", new HttpURI("https://" + host + ":" + port + "/async"), HttpVersion.HTTP_2, requestFields);
        // Create the HTTP/2 HEADERS frame representing the HTTP request.
        HeadersFrame headersFrame = new HeadersFrame(1, request, null, false);

        //PrintingFramesHandler responseListener = new PrintingFramesHandler();
        CountDownLatch latch = new CountDownLatch(1);
        Stream.Listener.Adapter responseListener = new Stream.Listener.Adapter() {
            @Override
            public Stream.Listener onPush(Stream stream, PushPromiseFrame frame) {
                // System.out.println("[" + frame.getStreamId() + "] PUSH_PROMISE " + frame.getMetaData().toString());
                return new PrintingFramesHandler();
            }

            @Override
            public void onHeaders(Stream stream, HeadersFrame frame) {
                if (frame.isEndStream()) {
                    latch.countDown();
                }
                //System.out.println("[" + frame.getStreamId() + "] HEADERS " + frame.getMetaData().toString());
                //frame.getMetaData().getFields().forEach(field -> System.out.println("[" + stream.getId() + "]     " + field.getName() + ": " + field.getValue()));
            }

            @Override
            public void onData(Stream stream, DataFrame frame, Callback callback) {
                byte[] bytes = new byte[frame.getData().remaining()];
                frame.getData().get(bytes);
                // System.out.println("[" + frame.getStreamId() + "] DATA " + new String(bytes));
                callback.succeeded();
                if (frame.isEndStream()) {
                    latch.countDown();
                }

            }

            @Override

            public void onTimeout​(Stream stream, java.lang.Throwable x) {
                //System.out.println("Timeout" + x);
            }

            @Override
            public boolean onIdleTimeout​(Stream stream, java.lang.Throwable x) {
                return false;
            }
        };

//System.out.println(i);
        //Callback callback = Callback.NOOP;
        String contents = content;
        Promise<Stream> streamPromise = new Promise<Stream>() {
            DataCallBack dataCallback = new DataCallBack();

            @Override
            public void succeeded(Stream stream) {
//                getHttpChannel().setStream(stream);
                //stream.setIdleTimeout(request.getIdleTimeout());

//                if (content.hasContent() && !expects100Continue(request)) {
//                    boolean advanced = content.advance();
//                    boolean lastContent = trailers == null && content.isLast();
//                    if (advanced || lastContent) {
                ByteBuffer content = ByteBuffer.wrap(("" + contents + "" + i).getBytes());
                DataFrame requestContent = new DataFrame(stream.getId(), content, true);

                stream.data(requestContent, dataCallback);
                return;
//                    }
//                }
                //callback.succeeded();
            }

            @Override
            public void failed(Throwable failure) {
                System.err.println("SDCM");
                System.err.println("failse: " + failure);

                dataCallback.failed(failure);
            }

        };
        // Use the Stream object to send request content, if any, using a DATA frame.
        session.newStream(headersFrame, streamPromise, responseListener);
        latch.await(5, TimeUnit.SECONDS);
        //Stream str = streamPromise.get(5, TimeUnit.SECONDS);

//        ByteBuffer content = ByteBuffer.wrap(("tovanlam").getBytes());
//        DataFrame requestContent = new DataFrame(str.getId(), content, true);
//        DataCallBack dataCallback = new DataCallBack();
//        str.data(requestContent, dataCallback);
//        latch.await(5, TimeUnit.SECONDS);
//        System.out.println("Will Stuck IN HERE");
//        responseListener.getCompletedFuture().whenComplete((<any> i, <any> err) -> {
//            System.out.println("helloNOOOOOOOOOOOOOOOOOOOO" + i);
//            throw new RuntimeException("2");
//        });
////        // TimeUnit.SECONDS.sleep(1);
////        System.out.println("NO");
////        System.out.println("i ");
    }
}
