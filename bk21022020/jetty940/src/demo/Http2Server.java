package demo;

import demo.*;
import org.eclipse.jetty.alpn.ALPN;
import org.eclipse.jetty.alpn.server.ALPNServerConnectionFactory;
import org.eclipse.jetty.http2.HTTP2Cipher;
import org.eclipse.jetty.http2.server.HTTP2ServerConnectionFactory;
import org.eclipse.jetty.server.*;
import org.eclipse.jetty.servlet.ServletContextHandler;
import org.eclipse.jetty.servlet.ServletHolder;
import org.eclipse.jetty.util.resource.Resource;
import org.eclipse.jetty.util.ssl.SslContextFactory;

import org.eclipse.jetty.util.thread.QueuedThreadPool;

/**
 * Based on the example {@link org.eclipse.jetty.embedded.Http2Server} included in the jetty-project distribution.
 */
public class Http2Server {

    // In order to run this, you need the alpn-boot-XXX.jar in the bootstrap classpath.
    public static void main(String... args) throws Exception {

   

        int maxThreads = 10000;
        int minThreads = 10;
        int idleTimeout = 120;

        QueuedThreadPool threadPool = new QueuedThreadPool(maxThreads, minThreads, idleTimeout);

        Server server = new Server(threadPool);

        ServletContextHandler context = new ServletContextHandler(server, "/", ServletContextHandler.SESSIONS);
        //context.addServlet(new ServletHolder(new Servlet()), "/");

        ServletHolder holder = new ServletHolder(new PushEchoServlet());

        holder.setAsyncSupported(true);
        context.addServlet(holder,"/");
        context.setInitParameter( "maxCacheSize", "81920");
        //context.addServlet(new ServletHolder(new PushEchoServlet()), "/");
        server.setHandler(context);

        // HTTP Configuration
        HttpConfiguration http_config = new HttpConfiguration();

        http_config.setSecureScheme("https");
        http_config.setSecurePort(8443);

        // SSL Context Factory for HTTPS and HTTP/2
        SslContextFactory sslContextFactory = new SslContextFactory();

        sslContextFactory.setKeyStoreResource(Resource.newClassPathResource("/resources/keystore"));

        System.out.println("resource: " + Resource.newClassPathResource("/resources/keystore"));
        //Http2JavaServerTest.class.getClassLoader().getResourceAsStream("keystore.p12");

        sslContextFactory.setKeyStorePassword("Vttek@123");
        sslContextFactory.setKeyManagerPassword("Vttek@123");
        sslContextFactory.setCipherComparator(HTTP2Cipher.COMPARATOR);

        // HTTPS Configuration
        HttpConfiguration https_config = new HttpConfiguration(http_config);

        https_config.addCustomizer(new SecureRequestCustomizer());

        // HTTP/2 Connection Factory
        HTTP2ServerConnectionFactory h2 = new HTTP2ServerConnectionFactory(https_config);
//        NegotiatingServerConnectionFactory.STARTING;
        ALPNServerConnectionFactory alpn = new ALPNServerConnectionFactory();

        alpn.setDefaultProtocol("h2");

        // SSL Connection Factory
        SslConnectionFactory ssl = new SslConnectionFactory(sslContextFactory, alpn.getProtocol());

        // HTTP/2 Connector
        ServerConnector http2Connector
                = new ServerConnector(server, ssl, alpn, h2, new HttpConnectionFactory(https_config));

        http2Connector.setPort(8443);
        server.addConnector(http2Connector);

        ALPN.debug = true;

        server.start();

        server.join();
    }
}
