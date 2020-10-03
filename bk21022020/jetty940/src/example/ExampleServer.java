/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package example;


import org.eclipse.jetty.server.Connector;
import org.eclipse.jetty.server.Handler;
import org.eclipse.jetty.server.Server;
import org.eclipse.jetty.server.ServerConnector;
import org.eclipse.jetty.server.handler.DefaultHandler;
import org.eclipse.jetty.server.handler.HandlerCollection;
import org.eclipse.jetty.servlet.ServletContextHandler;

public class ExampleServer
{
    public static void main( String[] args ) throws Exception
    {
        Server server = new Server();

        ServerConnector connector = new ServerConnector(server);
        connector.setPort(8000);
        server.setConnectors(new Connector[] { connector });

        ServletContextHandler context = new ServletContextHandler();
        context.setContextPath("/");
      //  context.addServlet(HelloServlet.class, "/hello");
        context.addServlet(AsyncEchoServlet.class, "/echo/*").setAsyncSupported(true);

        HandlerCollection handlers = new HandlerCollection();
        handlers.setHandlers(new Handler[] { context, new DefaultHandler() });
        
        server.setHandler(handlers);

        server.start();
        server.join();
    }
}