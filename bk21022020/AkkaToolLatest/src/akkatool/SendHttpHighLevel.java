/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package akkatool;

import akkatool.*;
import akka.actor.ActorSystem;
import akka.http.javadsl.Http;
import akka.http.javadsl.model.ContentTypes;
import akka.http.javadsl.model.HttpEntities;
import akka.http.javadsl.model.HttpEntity;
import akka.http.javadsl.model.HttpRequest;
import akka.http.javadsl.model.HttpResponse;
import akka.http.javadsl.model.StatusCodes;
import akka.http.javadsl.model.Uri;
import akka.http.javadsl.settings.ClientConnectionSettings;
import akka.http.javadsl.settings.ConnectionPoolSettings;
import akka.http.javadsl.settings.ParserSettings;
import akka.stream.ActorMaterializer;
import akka.stream.ActorMaterializerSettings;
import akka.util.ByteString;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.CompletionStage;
import java.util.concurrent.TimeUnit;
import scala.concurrent.duration.FiniteDuration;

/**
 *
 * @author thuanlk
 */
public class SendHttpHighLevel {

    public static void main(String[] args) throws InterruptedException, UnknownHostException {

        int threadTimeOut = Integer.getInteger("threadTimeOut", 100000000);
        int typeSend = Integer.getInteger("typeSend", 0);
        int isLog = Integer.getInteger("isLog", 0);
        long startSend = System.currentTimeMillis();

        final Statistic st = new Statistic("REST");
        // final String url = "http://172.16.28.235:8080/greeting?name=hello";
        final String USER_AGENT = "Mozilla/5.0";

        int numberThread = Integer.getInteger("numberThread", 1);
        int poolSize = Integer.getInteger("poolSize", 1);
        int msgSize = Integer.getInteger("msgSize", 300);
        int maxOpenRequest = Integer.getInteger("maxOpenRequest", 32);
        int pipeliningLimit = Integer.getInteger("pipeLine", 1);
        String host = System.getProperty("host", "127.0.0.1");
        String port = System.getProperty("port", "8080");

        String link = "http://" + host + ":" + port + "/greeter";
        //   String link = "http://172.16.28.247:9008/OK";
        System.out.println("numberThread: " + numberThread);
//
//        PoolingHttpClientConnectionManager pool = new PoolingHttpClientConnectionManager();
//        pool.setDefaultMaxPerRoute(poolSize);
//        pool.setMaxTotal(poolSize);
//        final CloseableHttpClient httpclient = HttpClients.custom().setConnectionManager(pool).build();

        ActorSystem system = ActorSystem.create("routes");
//        final ExecutionContext ex = system.dispatchers().lookup("my-dispatcher").;
        system.dispatchers().settings().config().getValue("akka.actor");

//       system.dispatchers().cachingConfig().withValue("akka.actor.default-blocking-io-dispatcher.thread-pool-executor.fixed-pool-size",
//                        ConfigValueFactory.fromAnyRef(456));
        Http http = Http.get(system);
        final ActorMaterializer materializer
                = ActorMaterializer.create(ActorMaterializerSettings
                        .create(system)
                        .withStreamRefSettings(ActorMaterializerSettings.create(system).streamRefSettings().withBufferCapacity(0)
                                .withSubscriptionTimeout(FiniteDuration.Zero())
                        )
                        .withMaxFixedBufferSize(0),
                        system);
//        final ActorMaterializer materializer
//                = ActorMaterializer.create(ActorMaterializerSettings.create(system).withInputBuffer(16, 32), system);

        System.out.println("initial size " + materializer.settings().initialInputBufferSize() + "  max input " + materializer.settings().maxInputBufferSize());

        //   akka.http.host-connection
        final ParserSettings parserSettings = ParserSettings.create(system);
        final ClientConnectionSettings clientConSettings = ClientConnectionSettings.create(system)
                .withParserSettings(parserSettings) // .withIdleTimeout(Duration.fromNanos(1));
                ;

        //  clientConSettings.withConnectingTimeout(newValue)
        final ConnectionPoolSettings clientSettings = ConnectionPoolSettings.create(system)
                .withConnectionSettings(clientConSettings)
                .withMaxConnections(poolSize)
                .withPipeliningLimit(pipeliningLimit)
                .withMaxOpenRequests(maxOpenRequest) //                .withPipeliningLimit(100000)
                //                .withIdleTimeout(Duration.fromNanos(1))
                //                .withMaxRetries(0)
                ;
        ;

        System.err.println("" + clientSettings.getIdleTimeout());

        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < msgSize; i++) {
            sb.append("x");
        }
        final String name = sb.toString();

        List<Thread> listThread = new ArrayList<>();
        for (int i = 0; i < numberThread; i++) {
            Thread t = new Thread(new Runnable() {
                @Override
                public void run() {
                    int i = 1;
                    boolean stopSend = false;
                    while (!stopSend) {
                        try {

//                            //HttpGet request = new HttpGet(link + name+""+i);
//                            HttpPost request = new HttpPost(link);
//                             // HttpGet request = new HttpGet(link );
//                            request.addHeader("User-Agent", USER_AGENT);
//                            request.setEntity(new StringEntity(name));
//                            st.countTPSSend();
//                            long start = System.currentTimeMillis();
//                            CloseableHttpResponse response = httpclient.execute(request);
//                            HttpEntity entity = response.getEntity();
////                            EntityUtils.consume(entity);
//                            long resTime = System.currentTimeMillis()- start;
////                            System.out.println("Response Code : " + response.getStatusLine().getStatusCode());
//                            BufferedReader rd = new BufferedReader(new InputStreamReader(entity.getContent()));
//                            StringBuilder result = new StringBuilder();
//                            String line;
//                            while ((line = rd.readLine()) != null) {
//                                result.append(line);
//                            }
//               // System.out.println(result.toString());
//                            st.update(resTime);
//                            response.close();
                           // Uri uri = Uri.create(link);

//https://doc.akka.io/docs/akka-http/current/client-side/host-level.html#requesting-a-host-connection-pool
                            HttpRequest request1 = HttpRequest.POST(link).withEntity(
                                    HttpEntities.create(ContentTypes.TEXT_PLAIN_UTF8, name));
                            st.countTPSSend();
                            long start = System.currentTimeMillis();
                            final CompletionStage<HttpResponse> responseFuture = http.singleRequest(request1,
                                    Http.get(system).defaultClientHttpsContext(),
                                    clientSettings, system.log(), materializer);

                            HttpResponse httpResponse = responseFuture.toCompletableFuture().get();
                            long resTime = System.currentTimeMillis() - start;
                            if (typeSend == 0) {
                                //Normal Get Response to String, dont have consume
                                if (httpResponse.status() == StatusCodes.FORBIDDEN) {
                                    //  System.out.println("FORBIDDEN");
//                                httpResponse.entity().getDataBytes().ca
//                                httpResponse.entity().getDataBytes().runWith(Sink.cancelled(), materializer);
                                } else {

                                    String message = ((HttpEntity.Strict) httpResponse.entity()).getData().utf8String();
                                    //System.out.println(message);
                                    if (message.length() < msgSize && message.length() != 12) {
                                        System.err.println("FAILSE " + message.length() + " < " + msgSize);
                                    } else {
                                        if (isLog == 1) {
                                            System.out.println("message " + message.length());
                                        }
                                    }

                                }

                            } else if (typeSend == 1) {

                                // if(httpResponse.status())
                                final CompletionStage<HttpEntity.Strict> strictEntity = httpResponse.entity().toStrict(
                                        FiniteDuration.create(3, TimeUnit.SECONDS).toMillis(), materializer);
                                final CompletionStage<String> rs
                                        = strictEntity
                                                .thenCompose(strict
                                                        -> strict.getDataBytes()
                                                        .runFold(ByteString.empty(), (acc, b) -> acc.concat(b), materializer)
                                                        .thenApply(s -> {

                                                            return s.utf8String();
                                                        })
                                                );

                                rs.whenComplete((done, ex) -> {

                                    if (done.length() < msgSize && done.length() != 12) {

                                        System.err.println("FAILSE " + done.length() + " < " + msgSize);
                                    } else {
                                        if (isLog == 1) {
                                            System.out.println("done " + done.length());
                                        }

                                    }

                                });

                            } else {

                            }
                            // httpResponse.

                            /*      
                            
                            Tao ket noi cho tung request mot
                            HttpRequest request1 = HttpRequest.POST(link).withEntity(HttpEntities.create(ContentTypes.TEXT_PLAIN_UTF8, name));
                            final Flow<HttpRequest, HttpResponse, CompletionStage<OutgoingConnection>> connectionFlow
                                    = Http.get(system).outgoingConnection(toHost("localhost", 8080));
                            final CompletionStage<HttpResponse> responseFuture
                                    = // This is actually a bad idea in general. Even if the `connectionFlow` was instantiated only once above,
                                    // a new connection is opened every single time, `runWith` is called. Materialization (the `runWith` call)
                                    // and opening up a new connection is slow.
                                    //
                                    // The `outgoingConnection` API is very low-level. Use it only if you already have a `Source[HttpRequest, _]`
                                    // (other than Source.single) available that you want to use to run requests on a single persistent HTTP
                                    // connection.
                                    //
                                    // Unfortunately, this case is so uncommon, that we couldn't come up with a good example.
                                    //
                                    // In almost all cases it is better to use the `Http().singleRequest()` API instead.
                                    Source.single(request1)
                                            .via(connectionFlow)
                                            .runWith(Sink.<HttpResponse>head(), materializer);


                             */
                            st.update(resTime);
                            if (start - startSend > threadTimeOut) {
                                stopSend = true;
                            }

                        } catch (Exception ex) {
                            ex.printStackTrace();
                        }
                    }
//                    
                }
            });
            listThread.add(t);
        }

        for (Thread t : listThread) {
            t.start();
        }

        for (Thread t : listThread) {
            t.join();
        }
    }
}

// java -cp "./lib/*.jar:NettyNew.jar" -Dhost=172.16.28.247 -Dport=9093 -Dtps=100000 -DnumberThread=100 com.viettel.vocs.test.SendNetty
//SimpleConfigObject({"additional-serialization-bindings":{},
//"allow-java-serialization":"on","creation-timeout":"20s",
//"debug":{"autoreceive":"off","event-stream":"off","fsm":"off",
//"lifecycle":"off","receive":"off","router-misconfiguration":"off","unhandled":"off"}
//,"default-blocking-io-dispatcher":
//{"executor":"thread-pool-executor","thread-pool-executor":
//{"fixed-pool-size":16},"throughput":1,"type":"Dispatcher"},""
//+ "default-dispatcher":{"affinity-pool-executor":{"fair-work-distribution":{"threshold":128},"idle-cpu-level":5,
//"parallelism-factor":0.8,"parallelism-max":64,"parallelism-min":4,
//"queue-selector":"akka.dispatch.affinity.FairDistributionHashCache",
//"rejection-handler":"akka.dispatch.affinity.ThrowOnOverflowRejectionHandler","task-queue-size":512},
//"attempt-teamwork":"on","default-executor":{"fallback":"fork-join-executor"},
//"executor":"default-executor","fork-join-executor":{"parallelism-factor":3,"parallelism-max":64,"parallelism-min":8,"task-peeking-mode":"FIFO"},""
//+ "mailbox-requirement":"","shutdown-timeout":"1s","thread-pool-executor":{"allow-core-timeout":"on","core-pool-size-factor":3,"core-pool-size-max":64,"core-pool-size-min":8,"fixed-pool-size":"off","keep-alive-time":"60s","max-pool-size-factor":3,"max-pool-size-max":64,"max-pool-size-min":8,"task-queue-size":-1,"task-queue-type":"linked"},"throughput":5,"throughput-deadline-time":"0ms","type":"Dispatcher"},"default-mailbox":{"mailbox-capacity":1000,"mailbox-push-timeout-time":"10s","mailbox-type":"akka.dispatch.UnboundedMailbox","stash-capacity":-1},"deployment":{"/IO-DNS/async-dns":{"mailbox":"unbounded","nr-of-instances":1,"router":"round-robin-pool"},"/IO-DNS/inet-address":{"mailbox":"unbounded","nr-of-instances":4,"router":"consistent-hashing-pool"},"/IO-DNS/inet-address/*":{"dispatcher":"akka.actor.default-blocking-io-dispatcher"},"default":{"cluster":{"allow-local-routees":"on","enabled":"off","max-nr-of-instances-per-node":1,"max-total-nr-of-instances":10000,"use-role":"","use-roles":[]},"dispatcher":"","mailbox":"","nr-of-instances":1,"optimal-size-exploring-resizer":{"action-interval":"5s","chance-of-exploration":0.4,"chance-of-ramping-down-when-full":0.2,"downsize-after-underutilized-for":"72h","downsize-ratio":0.8,"enabled":"off","explore-step-size":0.1,"lower-bound":1,"optimization-range":16,"upper-bound":10,"weight-of-latest-metric":0.5},"resizer":{"backoff-rate":0.1,"backoff-threshold":0.3,"enabled":"off","lower-bound":1,"messages-per-resize":10,"pressure-threshold":1,"rampup-rate":0.2,"upper-bound":10},"routees":{"paths":[]},"router":"from-code","tail-chopping-router":{"interval":"10 milliseconds"},"virtual-nodes-factor":10,"within":"5 seconds"}},"dsl":{"default-timeout":"5s","inbox-size":1000},"enable-additional-serialization-bindings":"on","guardian-supervisor-strategy":"akka.actor.DefaultSupervisorStrategy","java-serialization-disabled-additional-serialization-bindings":{},"mailbox":{"bounded-control-aware-queue-based":{"mailbox-type":"akka.dispatch.BoundedControlAwareMailbox"},"bounded-deque-based":{"mailbox-type":"akka.dispatch.BoundedDequeBasedMailbox"},"bounded-queue-based":{"mailbox-type":"akka.dispatch.BoundedMailbox"},"logger-queue":{"mailbox-type":"akka.event.LoggerMailboxType"},"requirements":{"akka.dispatch.BoundedControlAwareMessageQueueSemantics":"akka.actor.mailbox.bounded-control-aware-queue-based","akka.dispatch.BoundedDequeBasedMessageQueueSemantics":"akka.actor.mailbox.bounded-deque-based","akka.dispatch.BoundedMessageQueueSemantics":"akka.actor.mailbox.bounded-queue-based","akka.dispatch.ControlAwareMessageQueueSemantics":"akka.actor.mailbox.unbounded-control-aware-queue-based","akka.dispatch.DequeBasedMessageQueueSemantics":"akka.actor.mailbox.unbounded-deque-based","akka.dispatch.MultipleConsumerSemantics":"akka.actor.mailbox.unbounded-queue-based","akka.dispatch.UnboundedControlAwareMessageQueueSemantics":"akka.actor.mailbox.unbounded-control-aware-queue-based","akka.dispatch.UnboundedDequeBasedMessageQueueSemantics":"akka.actor.mailbox.unbounded-deque-based","akka.dispatch.UnboundedMessageQueueSemantics":"akka.actor.mailbox.unbounded-queue-based","akka.event.LoggerMessageQueueSemantics":"akka.actor.mailbox.logger-queue"},"unbounded-control-aware-queue-based":{"mailbox-type":"akka.dispatch.UnboundedControlAwareMailbox"},"unbounded-deque-based":{"mailbox-type":"akka.dispatch.UnboundedDequeBasedMailbox"},"unbounded-queue-based":{"mailbox-type":"akka.dispatch.UnboundedMailbox"}},"provider":"local","router":{"type-mapping":{"balancing-pool":"akka.routing.BalancingPool","broadcast-group":"akka.routing.BroadcastGroup","broadcast-pool":"akka.routing.BroadcastPool","consistent-hashing-group":"akka.routing.ConsistentHashingGroup","consistent-hashing-pool":"akka.routing.ConsistentHashingPool","from-code":"akka.routing.NoRouter","random-group":"akka.routing.RandomGroup","random-pool":"akka.routing.RandomPool","round-robin-group":"akka.routing.RoundRobinGroup","round-robin-pool":"akka.routing.RoundRobinPool","scatter-gather-group":"akka.routing.ScatterGatherFirstCompletedGroup","scatter-gather-pool":"akka.routing.ScatterGatherFirstCompletedPool","smallest-mailbox-pool":"akka.routing.SmallestMailboxPool","tail-chopping-group":"akka.routing.TailChoppingGroup","tail-chopping-pool":"akka.routing.TailChoppingPool"}},"serialization-bindings":{"[B":"bytes","akka.cluster.ClusterMessage":"akka-cluster","akka.cluster.ddata.ReplicatedDataSerialization":"akka-replicated-data","akka.cluster.ddata.Replicator$ReplicatorMessage":"akka-data-replication","akka.cluster.routing.ClusterRouterPool":"akka-cluster","akka.persistence.serialization.Message":"akka-persistence-message","akka.persistence.serialization.Snapshot":"akka-persistence-snapshot","akka.stream.SinkRef":"akka-stream-ref","akka.stream.SourceRef":"akka-stream-ref","akka.stream.impl.streamref.StreamRefsProtocol":"akka-stream-ref","akka.testkit.JavaSerializable":"java","java.io.Serializable":"java"},"serialization-identifiers":{"akka.cluster.ddata.protobuf.ReplicatedDataSerializer":11,"akka.cluster.ddata.protobuf.ReplicatorMessageSerializer":12,"akka.cluster.protobuf.ClusterMessageSerializer":5,"akka.persistence.serialization.MessageSerializer":7,"akka.persistence.serialization.SnapshotSerializer":8,"akka.serialization.ByteArraySerializer":4,"akka.serialization.JavaSerializer":1,"akka.stream.serialization.StreamRefSerializer":30,"akka.testkit.TestMessageSerializer":23},"serialize-creators":"off","serialize-messages":"off","serializers":{"akka-cluster":"akka.cluster.protobuf.ClusterMessageSerializer","akka-data-replication":"akka.cluster.ddata.protobuf.ReplicatorMessageSerializer","akka-persistence-message":"akka.persistence.serialization.MessageSerializer","akka-persistence-snapshot":"akka.persistence.serialization.SnapshotSerializer","akka-replicated-data":"akka.cluster.ddata.protobuf.ReplicatedDataSerializer","akka-stream-ref":"akka.stream.serialization.StreamRefSerializer","bytes":"akka.serialization.ByteArraySerializer","java":"akka.serialization.JavaSerializer","test-message-serializer":"akka.testkit.TestMessageSerializer"},"typed":{"timeout":"5s"},"unstarted-push-timeout":"10s","warn-about-java-serializer-usage":"on","warn-on-no-serialization-verification":"on"})
