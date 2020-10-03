/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package example;

import org.eclipse.jetty.client.HttpClient;
import org.eclipse.jetty.client.api.Result;
import org.eclipse.jetty.client.util.BufferingResponseListener;

/**
 *
 * @author vttek
 */
public class ExampleClient {

    public static void main(String[] args) throws Exception {
        // Instantiate HttpClient
        HttpClient httpClient = new HttpClient();

        httpClient.setIdleTimeout(100);
        httpClient.setMaxConnectionsPerDestination(100);
        httpClient.setTCPNoDelay(true);
        httpClient.setFollowRedirects(false);
        //httpClient.setMaxRetries(3);
// Configure HttpClient, for example:
        //  httpClient.setFollowRedirects(false);
        httpClient.start();

// Start HttpClient
////////////////////////////////////////////////////////////////////////
//        try {
//            httpClient.newRequest("http://localhost/async")
//                    .timeout(3, TimeUnit.SECONDS)
//                    //.send();
//                    .send(result -> {
//                        System.out.println("ECHo" + result);
//                    });
//        } catch (Exception ex) {
//            System.err.println("ex " + ex);
//        }
///////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
//        InputStreamResponseListener listener = new InputStreamResponseListener();
////        httpClient.newRequest("http://localhost:9000/async")
////                .send(listener);
//        httpClient.newRequest("http://localhost:8000/echo")
//                .send(listener);
//// Wait for the response headers to arrive
//        Response response = listener.get(5, TimeUnit.SECONDS);
//
//// Look at the response
//        if (response.getStatus() == HttpStatus.OK_200) {
//            // Use try-with-resources to close input stream.
//            try (InputStream responseContent = listener.getInputStream()) {
//                // Your logic here
//            }
//        }
//////////////////////////////////////////////////////////////////////////////////////////
       httpClient.newRequest("http://localhost:8000/echo")
        // Buffer response content up to 8 MiB
        .send(new BufferingResponseListener(8 * 1024 * 1024)
        {
            @Override
            public void onComplete(Result result)
            {
                if (!result.isFailed())
                {
                    byte[] responseContent = getContent();
                    // Your logic here
                }
                System.err.println("res " + result);
            }
        });

        httpClient.stop();
    }
}
