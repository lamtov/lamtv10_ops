/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package client;

import server.*;
import java.util.concurrent.CompletableFuture;

import org.eclipse.jetty.http2.api.Stream;
import org.eclipse.jetty.http2.api.Stream.Listener;
import org.eclipse.jetty.http2.frames.DataFrame;
import org.eclipse.jetty.http2.frames.HeadersFrame;
import org.eclipse.jetty.http2.frames.PushPromiseFrame;
import org.eclipse.jetty.util.Callback;

public class ResponseFramesHandler extends Stream.Listener.Adapter {

    private final CompletableFuture<Void> completedFuture = new CompletableFuture<>();

    public CompletableFuture<Void> getCompletedFuture() {
        return completedFuture;
    }

    @Override
    public Listener onPush(Stream stream, PushPromiseFrame frame) {
        //System.out.println("[" + frame.getStreamId() + "] PUSH_PROMISE " + frame.getMetaData().toString());
        return new ResponseFramesHandler();
    }

    @Override
    public void onHeaders(Stream stream, HeadersFrame frame) {
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
            completedFuture.complete(null);
        }
    }
}