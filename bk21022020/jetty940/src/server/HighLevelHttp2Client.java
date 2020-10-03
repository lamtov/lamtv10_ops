/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package server;

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


import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.eclipse.jetty.client.HttpClient;
import org.eclipse.jetty.client.api.ContentResponse;
import org.eclipse.jetty.http2.client.HTTP2Client;
import org.eclipse.jetty.http2.client.http.HttpClientTransportOverHTTP2;


@SuppressWarnings("serial")
public class HighLevelHttp2Client {


    public void highLevelApiTest() throws Exception {
        
        
        // start the test server
        class MyServlet extends HttpServlet { 
            
            @Override
            protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
                resp.getOutputStream().write("...my body data...".getBytes());
            }
        };
        
       
        
        
        // create a low-level jetty HTTP/2 client
        HTTP2Client lowLevelClient = new HTTP2Client();
        lowLevelClient.start();
        
        // create a high-level jetty HTTP/2 client
        HttpClient client = new HttpClient(new HttpClientTransportOverHTTP2(lowLevelClient), null);
        client.start();


        // and perform the http transaction
        ContentResponse response = client.GET("https://localhost:" + 8443);
        System.out.println(response.getVersion() + " " + response.getStatus() + " ");
       
        client.stop();
       
    }
}