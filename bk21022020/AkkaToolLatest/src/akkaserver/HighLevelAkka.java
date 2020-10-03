/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package akkaserver;

/**
 *
 * @author Administrator
 */
import akka.NotUsed;
import akka.actor.ActorSystem;
import akka.dispatch.MessageDispatcher;
import akka.http.impl.settings.ServerSettingsImpl;
import akka.http.javadsl.ConnectHttp;
import akka.http.javadsl.Http;
import akka.http.javadsl.ServerBinding;
import akka.http.javadsl.model.HttpEntity;
import akka.http.javadsl.model.HttpRequest;
import akka.http.javadsl.model.HttpResponse;
import akka.http.javadsl.model.StatusCodes;
import akka.http.javadsl.server.AllDirectives;
import akka.http.javadsl.server.Route;
import akka.http.javadsl.settings.ParserSettings;
import akka.http.javadsl.settings.ServerSettings;
import akka.stream.ActorMaterializer;
import akka.stream.javadsl.Flow;
import com.typesafe.config.Config;
import com.typesafe.config.ConfigFactory;
import java.util.HashMap;
import java.util.Map;

import java.util.concurrent.CompletionStage;
import java.util.concurrent.TimeUnit;
import scala.concurrent.duration.Duration;
import scala.concurrent.duration.FiniteDuration;

public class HighLevelAkka extends AllDirectives {

    public Map<String, Integer> mapConnection = new HashMap<String, Integer>();
    public static int maxRequest = 0;

    public static void main(String[] args) throws Exception {

        int port = Integer.getInteger("port", 8080);
        maxRequest = Integer.getInteger("maxRequest", 10000);
        // boot up server using the route as defined below
        Config config = ConfigFactory.load();
         ActorSystem system = ActorSystem.create("routes");
       // ActorSystem system = ActorSystem.create("routes", config.getConfig("myServerConfig").withFallback(config));

        //  system.dispatchers().defaultDispatcherConfig().
        // System.err.println(""+ system.dispatchers().lookup("my-thread-pool-dispatcher"));
        final Http http = Http.get(system);
        final ActorMaterializer materializer = ActorMaterializer.create(system);
//        final ActorMaterializer materializer
//                = ActorMaterializer.create(ActorMaterializerSettings
//                        .create(system)
//                        .withStreamRefSettings(ActorMaterializerSettings.create(system).streamRefSettings().withBufferCapacity(0)
//                                .withSubscriptionTimeout(FiniteDuration.Zero())
//                        )
//                       // .withDispatcher("my-dispatcher")
//                        .withMaxFixedBufferSize(0),
//                        system);

        System.out.println("initial size " + materializer.settings().initialInputBufferSize() + "  max input " + materializer.settings().maxInputBufferSize()
                + " ---- " + materializer.settings().streamRefSettings().bufferCapacity()
                + "=====" + materializer.settings().streamRefSettings().demandRedeliveryInterval()
                + "======" + materializer.settings().streamRefSettings().subscriptionTimeout()
        );
//          system.dispatchers().registerConfigurator("myDispath", system.dispatchers().lo;

        // ;
        //    System.out.println("" + dispatcher);
        final MessageDispatcher dispatcher = system.dispatchers().defaultGlobalDispatcher();
        // System.out.println("" + dispatcher);
        System.err.println(system.dispatchers().settings().config().getValue("akka.actor.default-dispatcher").toString());
        //In order to access all directives we need an instance where the routes are define.

        //  System.out.println("GGGGGGGGGGGGGGGGGGGGGGGG::::::::::::BBBBBBBBBBBBBBBBBB: " + dispatcher.configurator().config());
//        System.err.println("DD:::: " + system.dispatchers().lookup("myDispath"));
        HighLevelAkka app = new HighLevelAkka();

        int pipeliningLimit = Integer.getInteger("pipeline", 16);
        int backlog = Integer.getInteger("backlog", 1000);
        int maxConnection = Integer.getInteger("maxConnection", 1024);
        int idleTimeout = Integer.getInteger("idleTimeout", 60000);
        int requestTimeout = Integer.getInteger("requestTimeout", 20000);
        int bindTimeout = Integer.getInteger("bindTimeout", 1000);
        int lingerTimeout = Integer.getInteger("lingerTimeout", 60000);
        final ParserSettings parserSettings = ParserSettings.create(system);
        // parserSettings.w
        final ServerSettings serverSettings = ServerSettings.create(system)
                .withParserSettings(parserSettings)
                .withRemoteAddressHeader(true)
                .withMaxConnections(maxConnection)
                .withPipeliningLimit(pipeliningLimit)
                .withBacklog(backlog)
                .withTimeouts(new ServerSettingsImpl.Timeouts(Duration.create(idleTimeout, TimeUnit.MILLISECONDS),
                        Duration.create(requestTimeout, TimeUnit.MILLISECONDS),
                        Duration.create(bindTimeout, TimeUnit.MILLISECONDS),
                        Duration.create(lingerTimeout, TimeUnit.MILLISECONDS)));

        final Flow<HttpRequest, HttpResponse, NotUsed> routeFlow = app.createRoute(materializer).flow(system, materializer);
        final CompletionStage<ServerBinding> binding = http.bindAndHandle(routeFlow,
                ConnectHttp.toHost("0.0.0.0", port),
                serverSettings,
                system.log(),
                materializer
        );

        System.err.println("time OUT " + serverSettings.getTimeouts());

        System.out.println("Server online at http://localhost:" + port + "/\nPress RETURN to stop...");
        System.in.read(); // let it run until user presses return

        binding
                .thenCompose(ServerBinding::unbind) // trigger unbinding from the port
                .thenAccept(unbound -> system.terminate()); // and shutdown when done
    }

    private Route createRoute(ActorMaterializer materializer) {
        System.out.println("serverakka.HighLevelAkka.createRoute()====================1OKKKNEWWWWW");
        final FiniteDuration timeout = FiniteDuration.create(3, TimeUnit.SECONDS);
//        final Route routeGreeter = extractStrictEntity(timeout, (strict)
//                -> extractClientIP(remoteAddr -> {
//                    String key = remoteAddr.getAddress().toString() + remoteAddr.getPort();
//                    if (mapConnection.containsKey(key)) {
//                        int countRequest = mapConnection.get(key) + 1;
//
//                        mapConnection.put(key, countRequest);
//                    } else {
//                        System.out.println("New connection from " + key);
//                        mapConnection.put(key, 1);
//                    }
//
//                    if (mapConnection.get(key) < maxRequest) {
//
//                        return complete(strict.getData().utf8String());
//                    } else {
//                        mapConnection.remove(key);
//
//                        if (mapConnection.size() > 10) {
//                            System.out.println("" + mapConnection.size());
//                        }
//                        return withoutSizeLimit(() //                                -> extractDataBytes(bytes -> {
//                                //
//                                //                                    int a = strict.getData().utf8String().length();
//                                //                                    // Closing connections, method 1 (eager):
//                                //                                    // we deem this request as illegal, and close the connection right away:
//                                //                                    //  bytes.runWith(Sink.cancelled(), materializer);  // "brutally" closes the connection
//                                //
//                                //                                    //strict.getData().runWith(Sink.cancelled(), materializer);
//                                //                                    return respondWithHeader(Connection.create("close"), ()
//                                //                                            -> complete(StatusCodes.FORBIDDEN, "Not allowed!"));
//                                //                                    // return complete(StatusCodes.FORBIDDEN, "Not allowed!");
//                                //
//                                //                                })
//                                -> extractRequest(r -> {
//                                    final CompletionStage<Done> res = r.discardEntityBytes(materializer).completionStage();
//
//                                    return onComplete(() -> res, done
//                                            -> // we only want to respond once the incoming data has been handled:
//                                            //complete("Finished writing data :" + done));
//                                            respondWithHeader(Connection.create("close"), ()
//                                                    -> complete(StatusCodes.FORBIDDEN, "Not allowed!")));
//                                })
//                        );
//
////                        
////                        return respondWithHeader(Connection.create("accept"), ()
////                                            -> complete(StatusCodes.ACCEPTED, "Not allowed!")
////                                    );
//                    }
//
//                }//    else complete("OK")
//                )
//        );

//        final Route s
//                = put(()
//                        -> withoutSizeLimit(()
//                        -> extractDataBytes(bytes -> {
//                    // Closing connections, method 1 (eager):
//                    // we deem this request as illegal, and close the connection right away:
//                  return  bytes.runWith(Sink.cancelled(), materializer);  // "brutally" closes the connection
//                  
//                    // Closing connections, method 2 (graceful):
//                    // consider draining connection and replying with `Connection: Close` header
//                    // if you want the client to close after this request/reply cycle instead:
////                    return respondWithHeader(Connection.create("close"), ()
////                            -> complete(StatusCodes.FORBIDDEN, "Not allowed!")
////                    );
//                })
//                )
//                );
        Route routeGreeter2 = toStrictEntity(timeout, ()
                -> extractClientIP(remoteAddress -> {
                    // String key = remoteAddr.getAddress().toString() + remoteAddr.getPort();

                    return extractRequest(req -> {
                        if (req.entity() instanceof HttpEntity.Strict) {
                            final HttpEntity.Strict strict = (HttpEntity.Strict) req.entity();

                            byte[] data = strict.getData().toArray();

                            String remoteAddr = remoteAddress.getAddress().orElse(null).toString() + ":" + remoteAddress.getPort();
                            String remoteHost = remoteAddress.getAddress().orElse(null).getHostAddress();
                            String hostAddr = "/" + req.getUri().getHost() + ":" + req.getUri().getPort();
                            String res = new String(data);
                         //   System.err.println("RES " + res);

                            //return complete("Request entity is strict, data=" + strict.getData().utf8String());
                            return complete(StatusCodes.OK, res);

                        } else {

                            return complete(StatusCodes.FAILED_DEPENDENCY);
                        }
                    });
                })
        );

        return route(post(()
                -> path("greeter", ()
                        -> routeGreeter2
                )
        // path("OK", () -> complete("OKL"))
        )
        );
//        return route(
//                path("hello", ()
//                        -> get(()
//                        -> complete("<h1>Say hello to akka-http</h1>"))));
    }
    /*   private Route createRoute2() {

        // BAD (due to blocking in Future, on default dispatcher)
        final Route routes = post(()
                -> completeWithFuture(CompletableFuture.supplyAsync(() -> { // uses defaultDispatcher
                    try {
                        Thread.sleep(5000L); // will block on default dispatcher,
                    } catch (InterruptedException e) {
                    }
                    return HttpResponse.create() // Starving the routing infrastructure
                            .withEntity(Long.toString(System.currentTimeMillis()));
                }))
        );

        return route(post(()
                -> path("greeter", ()
                        -> entity(Unmarshaller.entityToString(), (string)
                        -> {
                    System.out.println(string);
                    return complete("ok");
                })
                ))
        );

    }*/
 /* private Route createRoutes() {
        CheckHeader<MyJavaSession> checkHeader = new CheckHeader<>(getSessionManager());
        return route(
                randomTokenCsrfProtection(checkHeader, ()
                        -> route(
                        path("logout", ()
                                -> post(()
                                -> requiredSession(refreshable, sessionTransport, session
                                -> invalidateSession(refreshable, sessionTransport, ()
                                -> extractRequestContext(ctx -> {
                            LOGGER.info("Logging out {}", session.getUsername());
                            return onSuccess(() -> ctx.completeWith(HttpResponse.create()), routeResult
                                    -> complete("ok")
                            );
                        }
                        )
                        )
                        )
                        )
                        )
                )
                )
        );
    }*/
}

//
/*
SimpleConfigObject({"additional-serialization-bindings":{},"allow-java-serialization":"on","creation-timeout":"20s","debug":{"autoreceive":"off","event-stream":"off","fsm":"off","lifecycle":"off","receive":"off","router-misconfiguration":"off","unhandled":"off"},"default-blocking-io-dispatcher":{"executor":"thread-pool-executor","thread-pool-executor":{"fixed-pool-size":16},"throughput":1,"type":"Dispatcher"},
"default-dispatcher":{"affinity-pool-executor":{"fair-work-distribution":{"threshold":128},"idle-cpu-level":1,"parallelism-factor":0.8,"parallelism-max":64,
"parallelism-min":4,"queue-selector":"akka.dispatch.affinity.FairDistributionHashCache",
"rejection-handler":"akka.dispatch.affinity.ThrowOnOverflowRejectionHandler","task-queue-size":256}
,"attempt-teamwork":"on","default-executor":{"fallback":"affinity-pool-executor"},
"executor":"default-executor","fork-join-executor":
{"parallelism-factor":1,"parallelism-max":246,"parallelism-min":128,"task-peeking-mode":"FIFO"},
"mailbox-requirement":"","shutdown-timeout":"1s","thread-pool-executor":
{"allow-core-timeout":"on","core-pool-size-factor":3,"core-pool-size-max":64,
"core-pool-size-min":8,"fixed-pool-size":32,"keep-alive-time":"1s","max-pool-size-factor":3,""
+ "max-pool-size-max":64,"max-pool-size-min":8,"task-queue-size":-1,"task-queue-type":"linked"},
"throughput":100,"throughput-deadline-time":"0ms","type":"Dispatcher"},
"default-mailbox":{"mailbox-capacity":1000,"mailbox-push-timeout-time":"10s","mailbox-type":"akka.dispatch.UnboundedMailbox",
"stash-capacity":-1},"deployment":{"/IO-DNS/async-dns":{"mailbox":"unbounded","nr-of-instances":1,"router":"round-robin-pool"},
"/IO-DNS/inet-address":{"mailbox":"unbounded","nr-of-instances":4,"router":"consistent-hashing-pool"}
,"/IO-DNS/inet-address/*":{"dispatcher":"akka.actor.default-blocking-io-dispatcher"},
"default":{"cluster":{"allow-local-routees":"on","enabled":"off","max-nr-of-instances-per-node":1,""
+ "max-total-nr-of-instances":10000,"use-role":"","use-roles":[]},"dispatcher":"my-dispatchssser"
,"mailbox":"","nr-of-instances":1,"optimal-size-exploring-resizer":
{"action-interval":"5s","chance-of-exploration":0.4,"chance-of-ramping-down-when-full":0.2,"downsize-after-underutilized-for":"72h","downsize-ratio":0.8,"enabled":"off","explore-step-size":0.1,"lower-bound":1,"optimization-range":16,"upper-bound":10,"weight-of-latest-metric":0.5},"resizer":{"backoff-rate":0.1,"backoff-threshold":0.3,"enabled":"off","lower-bound":1,"messages-per-resize":10,"pressure-threshold":1,"rampup-rate":0.2,"upper-bound":10},"routees":{"paths":[]},"router":"from-code","tail-chopping-router":{"interval":"10 milliseconds"},"virtual-nodes-factor":10,"within":"5 seconds"}},"dsl":{"default-timeout":"5s","inbox-size":1000},"enable-additional-serialization-bindings":"on","guardian-supervisor-strategy":"akka.actor.DefaultSupervisorStrategy","java-serialization-disabled-additional-serialization-bindings":{},"mailbox":{"bounded-control-aware-queue-based":{"mailbox-type":"akka.dispatch.BoundedControlAwareMailbox"},"bounded-deque-based":{"mailbox-type":"akka.dispatch.BoundedDequeBasedMailbox"},"bounded-queue-based":{"mailbox-type":"akka.dispatch.BoundedMailbox"},"logger-queue":{"mailbox-type":"akka.event.LoggerMailboxType"},"requirements":{"akka.dispatch.BoundedControlAwareMessageQueueSemantics":"akka.actor.mailbox.bounded-control-aware-queue-based","akka.dispatch.BoundedDequeBasedMessageQueueSemantics":"akka.actor.mailbox.bounded-deque-based","akka.dispatch.BoundedMessageQueueSemantics":"akka.actor.mailbox.bounded-queue-based","akka.dispatch.ControlAwareMessageQueueSemantics":"akka.actor.mailbox.unbounded-control-aware-queue-based","akka.dispatch.DequeBasedMessageQueueSemantics":"akka.actor.mailbox.unbounded-deque-based","akka.dispatch.MultipleConsumerSemantics":"akka.actor.mailbox.unbounded-queue-based","akka.dispatch.UnboundedControlAwareMessageQueueSemantics":"akka.actor.mailbox.unbounded-control-aware-queue-based","akka.dispatch.UnboundedDequeBasedMessageQueueSemantics":"akka.actor.mailbox.unbounded-deque-based","akka.dispatch.UnboundedMessageQueueSemantics":"akka.actor.mailbox.unbounded-queue-based","akka.event.LoggerMessageQueueSemantics":"akka.actor.mailbox.logger-queue"},"unbounded-control-aware-queue-based":{"mailbox-type":"akka.dispatch.UnboundedControlAwareMailbox"},"unbounded-deque-based":{"mailbox-type":"akka.dispatch.UnboundedDequeBasedMailbox"},"unbounded-queue-based":{"mailbox-type":"akka.dispatch.UnboundedMailbox"}},"provider":"local","router":{"type-mapping":{"balancing-pool":"akka.routing.BalancingPool","broadcast-group":"akka.routing.BroadcastGroup","broadcast-pool":"akka.routing.BroadcastPool","consistent-hashing-group":"akka.routing.ConsistentHashingGroup","consistent-hashing-pool":"akka.routing.ConsistentHashingPool","from-code":"akka.routing.NoRouter","random-group":"akka.routing.RandomGroup","random-pool":"akka.routing.RandomPool","round-robin-group":"akka.routing.RoundRobinGroup","round-robin-pool":"akka.routing.RoundRobinPool","scatter-gather-group":"akka.routing.ScatterGatherFirstCompletedGroup","scatter-gather-pool":"akka.routing.ScatterGatherFirstCompletedPool","smallest-mailbox-pool":"akka.routing.SmallestMailboxPool","tail-chopping-group":"akka.routing.TailChoppingGroup","tail-chopping-pool":"akka.routing.TailChoppingPool"}},"serialization-bindings":{"[B":"bytes","akka.cluster.ClusterMessage":"akka-cluster","akka.cluster.ddata.ReplicatedDataSerialization":"akka-replicated-data","akka.cluster.ddata.Replicator$ReplicatorMessage":"akka-data-replication","akka.cluster.routing.ClusterRouterPool":"akka-cluster","akka.persistence.serialization.Message":"akka-persistence-message","akka.persistence.serialization.Snapshot":"akka-persistence-snapshot","akka.stream.SinkRef":"akka-stream-ref","akka.stream.SourceRef":"akka-stream-ref","akka.stream.impl.streamref.StreamRefsProtocol":"akka-stream-ref","akka.testkit.JavaSerializable":"java","java.io.Serializable":"java"},"serialization-identifiers":{"akka.cluster.ddata.protobuf.ReplicatedDataSerializer":11,"akka.cluster.ddata.protobuf.ReplicatorMessageSerializer":12,"akka.cluster.protobuf.ClusterMessageSerializer":5,"akka.persistence.serialization.MessageSerializer":7,"akka.persistence.serialization.SnapshotSerializer":8,"akka.serialization.ByteArraySerializer":4,"akka.serialization.JavaSerializer":1,"akka.stream.serialization.StreamRefSerializer":30,"akka.testkit.TestMessageSerializer":23},"serialize-creators":"off","serialize-messages":"off","serializers":{"akka-cluster":"akka.cluster.protobuf.ClusterMessageSerializer","akka-data-replication":"akka.cluster.ddata.protobuf.ReplicatorMessageSerializer","akka-persistence-message":"akka.persistence.serialization.MessageSerializer","akka-persistence-snapshot":"akka.persistence.serialization.SnapshotSerializer","akka-replicated-data":"akka.cluster.ddata.protobuf.ReplicatedDataSerializer","akka-stream-ref":"akka.stream.serialization.StreamRefSerializer","bytes":"akka.serialization.ByteArraySerializer","java":"akka.serialization.JavaSerializer","test-message-serializer":"akka.testkit.TestMessageSerializer"},"typed":{"timeout":"5s"},"unstarted-push-timeout":"10s","warn-about-java-serializer-usage":"on","warn-on-no-serialization-verification":"on"})
serverakka.HighLevelAkka.createRoute()====================1OKKKKKKKKKK
 */
