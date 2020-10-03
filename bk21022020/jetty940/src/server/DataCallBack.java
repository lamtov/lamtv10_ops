/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package server;

import org.eclipse.jetty.util.Callback;

import java.util.concurrent.CompletableFuture;

public class DataCallBack implements Callback {

	private final CompletableFuture<Void> completedFuture = new CompletableFuture<>();

	public CompletableFuture<Void> getCompletedFuture() {
		return completedFuture;
	}

	@Override
	public void succeeded() {
		completedFuture.complete(null);
	}

	@Override
	public void failed(Throwable throwable) {
		throwable.printStackTrace();
	}
}