/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package demo;

import demo.*;
import org.apache.commons.io.IOUtils;
import org.eclipse.jetty.server.Request;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;

public class PushEchoServlet extends HttpServlet {

    private String receivedData = ""; // POST data that we got from the client.

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws IOException {
        
       // System.out.println("?????????????????");
        
        switch (request.getMethod()) {
            
            case "GET":
               // System.out.println("?????????????????");
                if (request.getServletPath().contains("/data")) {
                    // This request does not necessarily come from the client. It may be triggered by the PUSH_PROMISE.
                    // However, when responding it does not make a difference if we respond to a client request or to a push promise.
                    
                    response.setContentType("text/plain");
                    response.getWriter().write("I received the following data: " + receivedData);
                } else {
                    showIndexHtml(response);
                }
                break;
            case "POST":
                handlePost(request, response);
                //push(request);
                break;
            default:
                showIndexHtml(response);
        }
    }

    private void handlePost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //Dat vao Queue........
//        char cbuf[] = new char[request.getContentLength()];
//        request.getReader().read(cbuf);
//        response.getWriter().write(cbuf);
        
        String receivedData = (String) IOUtils.readLines(request.getReader()).stream().reduce("", (a, b) -> a + " " + b);
       // System.out.println("fsafasfasdfasdfasdfasfasd" + receivedData);
        //response.setContentType("text/plain");
        response.getWriter().write(receivedData);
    }

    private void push(HttpServletRequest req) {
        Request baseRequest = Request.getBaseRequest(req);
        if (baseRequest.isPushSupported()) {
            baseRequest
                    .getPushBuilder()
                    .method("GET")
                    .path("/data")
                    .push();
        }
    }

    private void showIndexHtml(HttpServletResponse response) throws IOException {
        response.setContentType("text/html");
        try (InputStream in = this.getClass().getClassLoader().getResourceAsStream("index.html")){
            IOUtils.copy(in, response.getWriter());
        }

    }
}