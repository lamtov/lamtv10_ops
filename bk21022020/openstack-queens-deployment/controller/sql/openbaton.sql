CREATE DATABASE openbaton;
GRANT ALL PRIVILEGES ON openbaton.* TO 'openbaton'@'localhost'  IDENTIFIED BY "lamtv10";
GRANT ALL PRIVILEGES ON openbaton.* TO 'openbaton'@'%'  IDENTIFIED BY "lamtv10";

nfvo.rabbit.brokerIp=localhost
nfvo.rabbit.management.port=15672
nfvo.rabbitmq.autodelete=true
nfvo.rabbitmq.durable=true
nfvo.rabbitmq.exclusive=false

nfvo.rabbit.manager-registration-user.name=openbaton-manager-user
nfvo.rabbit.manager-registration-user.password=openbaton




# Create an AmqpAdmin bean.
spring.rabbitmq.dynamic=true
# Whether or not to requeue delivery failures; default `true`.
spring.rabbitmq.listener.simple.default-requeue-rejected=false
# RabbitMQ host.
spring.rabbitmq.host=${nfvo.rabbit.brokerIp}
# Minimum number of consumers.
spring.rabbitmq.listener.simple.concurrency=25
# Maximum number of consumers.
spring.rabbitmq.listener.simple.max-concurrency=100
# Login user to authenticate to the broker.
spring.rabbitmq.username=admin
# Login to authenticate against the broker.
spring.rabbitmq.password=openbaton
# RabbitMQ managementPort.
spring.rabbitmq.port=5672
# Requested heartbeat timeout, in seconds; zero for none.
spring.rabbitmq.requested-heartbeat=60



spring.datasource.username=admin
spring.datasource.password=changeme


../../jdk1.8.0_171/bin/java -jar -Dspring.conf.location=file:application.properties openbaton-nfvo-6.0.1.jar 

    rabbitmqctl delete_user guest
    rabbitmqctl add_user admin openbaton
    rabbitmqctl set_user_tags admin administrator
    rabbitmqctl set_permissions admin ".*" ".*" ".*"




 rabbitmqctl delete_user guest
    rabbitmqctl add_user openbaton-manager-user  openbaton

    rabbitmqctl set_user_tags openstack administrator
    rabbitmqctl set_permissions openbaton-manager-user  ".*" ".*" ".*"



    mysql



jdk1.8.0_171/bin/


java -jar -Dspring.conf.location=file:nse.properties network-slicing-engine-1.2.1.jar


../jdk1.8.0_171/bin/java -jar -Dspring.conf.location=file:application.properties openbaton-nfvo-6.0.1.jar
 2192  vim /etc/environment 
 2193  java --version
 2194  update-alternatives --config java
 2195  update-alternatives --install /usr/bin/java java /u01/jdk1.8.0_171/bin/java 3

 2196  update-alternatives --config java
 2197  java -version
 2198  java -jar -Dspring.conf.location=file:application.properties openbaton-nfvo-6.0.1.jar
 2199  history


1. java -jar -Dspring.conf.location=file:application.properties openbaton-nfvo-6.0.1.jar 

2. java -jar -Dspring.conf.location=file:vnfm.properties generic-vnfm-6.0.1-SNAPSHOT.jar

3. java -jar -Dspring.conf.location=file:nse.properties network-slicing-engine-1.2.1.jar

 {
   "name":"pop-1",
   "authUrl":"http://172.16.30.87:35357/v3",
   "tenant":"5fcdf48d7c864782883ea13f18201a81",
   "username":"admin",
   "password":"Vttek@123",
   "securityGroups":[
      "default"
   ],
   "type":"openstack",

}


 {
   "name":"pop-1",
   "authUrl":"http://172.16.31.239:5000/v3",
   "tenant":"bbbcbabaab804382acbe3f68604589e6",
   "username":"demo",
   "password":"GfvDCTgUVLYsotdmjCiK6tIRATsgjSTp",
   "type":"openstack",

}

{  
   "name":"pop-1",
   "authUrl":"http://172.16.31.239:5000/v3",
   "tenant":"069f9cb45f5b46d28d151b19bab0a472",
   "username":"openbaton",
   "password":"Vttek@123",
   "securityGroups":[  
      "default"
   ],
   "type":"openstack"
}
SET GLOBAL pxc_strict_mode=PERMISSIVE;






/usr/local/lib/openbaton/plugins/





zip -r test1.csar . -x ".*" -x "*/.*"






java.lang.IllegalStateException: Failed to execute CommandLineRunner
	at org.springframework.boot.SpringApplication.callRunner(SpringApplication.java:735) [spring-boot-1.5.11.RELEASE.jar!/:1.5.11.RELEASE]
	at org.springframework.boot.SpringApplication.callRunners(SpringApplication.java:716) [spring-boot-1.5.11.RELEASE.jar!/:1.5.11.RELEASE]
	at org.springframework.boot.SpringApplication.afterRefresh(SpringApplication.java:703) [spring-boot-1.5.11.RELEASE.jar!/:1.5.11.RELEASE]
	at org.springframework.boot.SpringApplication.run(SpringApplication.java:304) [spring-boot-1.5.11.RELEASE.jar!/:1.5.11.RELEASE]
	at org.springframework.boot.SpringApplication.run(SpringApplication.java:1118) [spring-boot-1.5.11.RELEASE.jar!/:1.5.11.RELEASE]
	at org.springframework.boot.SpringApplication.run(SpringApplication.java:1107) [spring-boot-1.5.11.RELEASE.jar!/:1.5.11.RELEASE]
	at org.openbaton.nfvo.main.Application.main(Application.java:48) [main-6.0.1-SNAPSHOT.jar!/:6.0.1-SNAPSHOT]
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method) ~[na:1.8.0_181]
	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62) ~[na:1.8.0_181]
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43) ~[na:1.8.0_181]
	at java.lang.reflect.Method.invoke(Method.java:498) ~[na:1.8.0_181]
	at org.springframework.boot.loader.MainMethodRunner.run(MainMethodRunner.java:48) [openbaton-nfvo-6.0.1.jar:6.0.1-SNAPSHOT]
	at org.springframework.boot.loader.Launcher.launch(Launcher.java:87) [openbaton-nfvo-6.0.1.jar:6.0.1-SNAPSHOT]
	at org.springframework.boot.loader.Launcher.launch(Launcher.java:50) [openbaton-nfvo-6.0.1.jar:6.0.1-SNAPSHOT]
	at org.springframework.boot.loader.JarLauncher.main(JarLauncher.java:51) [openbaton-nfvo-6.0.1.jar:6.0.1-SNAPSHOT]
Caused by: java.net.SocketException: Connection reset
	at java.net.SocketInputStream.read(SocketInputStream.java:210) ~[na:1.8.0_181]
	at java.net.SocketInputStream.read(SocketInputStream.java:141) ~[na:1.8.0_181]
	at org.apache.http.impl.io.SessionInputBufferImpl.streamRead(SessionInputBufferImpl.java:137) ~[httpcore-4.4.9.jar!/:4.4.9]
	at org.apache.http.impl.io.SessionInputBufferImpl.fillBuffer(SessionInputBufferImpl.java:153) ~[httpcore-4.4.9.jar!/:4.4.9]
	at org.apache.http.impl.io.SessionInputBufferImpl.readLine(SessionInputBufferImpl.java:282) ~[httpcore-4.4.9.jar!/:4.4.9]
	at org.apache.http.impl.conn.DefaultHttpResponseParser.parseHead(DefaultHttpResponseParser.java:138) ~[httpclient-4.5.5.jar!/:4.5.5]
	at org.apache.http.impl.conn.DefaultHttpResponseParser.parseHead(DefaultHttpResponseParser.java:56) ~[httpclient-4.5.5.jar!/:4.5.5]
	at org.apache.http.impl.io.AbstractMessageParser.parse(AbstractMessageParser.java:259) ~[httpcore-4.4.9.jar!/:4.4.9]
	at org.apache.http.impl.DefaultBHttpClientConnection.receiveResponseHeader(DefaultBHttpClientConnection.java:163) ~[httpcore-4.4.9.jar!/:4.4.9]
	at org.apache.http.impl.conn.CPoolProxy.receiveResponseHeader(CPoolProxy.java:165) ~[httpclient-4.5.5.jar!/:4.5.5]
	at org.apache.http.protocol.HttpRequestExecutor.doReceiveResponse(HttpRequestExecutor.java:273) ~[httpcore-4.4.9.jar!/:4.4.9]
	at org.apache.http.protocol.HttpRequestExecutor.execute(HttpRequestExecutor.java:125) ~[httpcore-4.4.9.jar!/:4.4.9]
	at org.apache.http.impl.execchain.MainClientExec.execute(MainClientExec.java:272) ~[httpclient-4.5.5.jar!/:4.5.5]
	at org.apache.http.impl.execchain.ProtocolExec.execute(ProtocolExec.java:185) ~[httpclient-4.5.5.jar!/:4.5.5]
	at org.apache.http.impl.execchain.RetryExec.execute(RetryExec.java:89) ~[httpclient-4.5.5.jar!/:4.5.5]
	at org.apache.http.impl.execchain.RedirectExec.execute(RedirectExec.java:111) ~[httpclient-4.5.5.jar!/:4.5.5]
	at org.apache.http.impl.client.InternalHttpClient.doExecute(InternalHttpClient.java:185) ~[httpclient-4.5.5.jar!/:4.5.5]
	at org.apache.http.impl.client.CloseableHttpClient.execute(CloseableHttpClient.java:83) ~[httpclient-4.5.5.jar!/:4.5.5]
	at org.apache.http.impl.client.CloseableHttpClient.execute(CloseableHttpClient.java:108) ~[httpclient-4.5.5.jar!/:4.5.5]
	at org.openbaton.nfvo.common.utils.rabbit.RabbitManager.createRabbitMqUser(RabbitManager.java:122) ~[common-6.0.1-SNAPSHOT.jar!/:6.0.1-SNAPSHOT]
	at org.openbaton.nfvo.system.SystemStartup.run(SystemStartup.java:87) ~[main-6.0.1-SNAPSHOT.jar!/:6.0.1-SNAPSHOT]
	at org.springframework.boot.SpringApplication.callRunner(SpringApplication.java:732) [spring-boot-1.5.11.RELEASE.jar!/:1.5.11.RELEASE]
	... 14 common frames omitted
rabbitmq-plugins enable rabbitmq_management