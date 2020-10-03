///*
// * To change this license header, choose License Headers in Project Properties.
// * To change this template file, choose Tools | Templates
// * and open the template in the editor.
// */
//package server;
//
//
//import java.io.IOException;
//
//import java.net.InetSocketAddress;
//
//import javax.servlet.ServletException;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//
//import org.eclipse.jetty.http.HttpFields;
//import org.eclipse.jetty.http.HttpURI;
//import org.eclipse.jetty.http.HttpVersion;
//import org.eclipse.jetty.http.MetaData;
//import org.eclipse.jetty.http2.api.Session;
//import org.eclipse.jetty.http2.api.Stream;
//import org.eclipse.jetty.http2.client.HTTP2Client;
//import org.eclipse.jetty.http2.frames.HeadersFrame;
//import org.eclipse.jetty.util.FuturePromise;
//import org.eclipse.jetty.util.Promise;
//import org.eclipse.jetty.util.ssl.SslContextFactory;
//import org.eclipse.jetty.util.Jetty;
//import java.util.concurrent.TimeUnit;
//
//import org.eclipse.jetty.http.HttpFields;
//import org.eclipse.jetty.http.HttpURI;
//import org.eclipse.jetty.http.HttpVersion;
//import org.eclipse.jetty.http.MetaData;
//import org.eclipse.jetty.http2.api.Session;
//import org.eclipse.jetty.http2.api.Stream;
//import org.eclipse.jetty.http2.api.server.ServerSessionListener;
//import org.eclipse.jetty.http2.client.HTTP2Client;
//import org.eclipse.jetty.http2.frames.DataFrame;
//import org.eclipse.jetty.http2.frames.HeadersFrame;
//import org.eclipse.jetty.util.Callback;
//import org.eclipse.jetty.util.FuturePromise;
//import org.eclipse.jetty.util.Jetty;
//import org.eclipse.jetty.util.Promise;
//import org.eclipse.jetty.util.ssl.SslContextFactory;
//import java.net.InetSocketAddress;
//import java.util.concurrent.TimeUnit;
//@SuppressWarnings("serial")
//public class LowLevelClient {
//        public static void main(String[] args) throws Exception {
//        long startTime = System.nanoTime();
//        // create a low-level jetty HTTP/2 client
//        SslContextFactory sslContextFactory = new SslContextFactory();
//        HTTP2Client lowLevelClient = new HTTP2Client();
//        
//         
//
//        lowLevelClient.addBean(sslContextFactory);
//        lowLevelClient.start();
//
//        
//        // create a new session which will open a (multiplexed) connection to the server  
//        FuturePromise<Session> sessionFuture = new FuturePromise<>();
//         
//        lowLevelClient.connect(sslContextFactory,new InetSocketAddress("jetty", 8443), new Session.Listener.Adapter(), sessionFuture);
//        Session session = sessionFuture.get(5, TimeUnit.SECONDS);
//      // Session session = sessionFuture.get(5, TimeUnit.SECONDS);
//        HttpFields requestFields = new HttpFields();
//        requestFields.put("User-Agent", lowLevelClient.getClass().getName() + "/" + Jetty.VERSION +"tovanlam");
//        // create the header frame 
//        requestFields.add("tpvam;a,", "lamtovan");
//        MetaData.Request metaData = new MetaData.Request("POST", new HttpURI("https://" + "jetty" + ":" + "8443" + "/"), HttpVersion.HTTP_2, requestFields);
//       // MetaData.Request metaData = new MetaData.Request("GET", HttpScheme.HTTPS, new HostPortHttpField("localhost:" + 8443), "/", HttpVersion.HTTP_2, new HttpFields());
//        HeadersFrame frame = new HeadersFrame(1, metaData, null, true);
//
//        // ... and perform the http transaction
//        PrintingFramesHandler framesHandler = new PrintingFramesHandler();
//        session.newStream(frame, new Promise.Adapter<Stream>(), framesHandler);
//
//        
//        
//        
//        // wait until response is received (PrintingFramesHandler will write the response frame to console) 
//        framesHandler.getCompletedFuture().get();
//        
//        
//        // shut down the client and server
//        lowLevelClient.stop();
//      
//    }
//}