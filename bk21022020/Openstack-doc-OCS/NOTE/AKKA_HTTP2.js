Http2 hơn gì so với HTTP1.1
1. Multiplexing and Concurrency: Cho rendering 1 HTML thì cần một số file như JS, CSS, IMage vì vậy nếu sử dụng HTTP thì client sẽ phải request với mỗi JS, CSS,Image file độc lập. Điều này cần 1 TCP connection cho mỗi Request --<> lãng phí.
   Cải tiến trong HTTP2 thay vì client yêu cầu cho từng tài nguyên thì một server sẽ tự push response tới client mà với mỗi TCP connection độc lập tất cả nội dung cần sẽ có mặt tới client. Điều này cho phép server hỗ trợ data cần thiết cho một web browser để render một web page mà không cần đợi cho phản hồi đầu tiên.

2. Stream Prioritization: Client có thể chỉ định tài nguyên nào quan trọng hơn những tài nguyên khác đối với server. Cho cung cấp việc đánh trọng số thì HTTP2 có cung cấp weight và dependency:		
		+ Mỗi stream ký một integer từ 1-256
		+ Mỗi stream cung cấp sự phụ thuộc rõ ràng vào các luồng khác.
		+ Sự kết hợp của cả phụ thuộc và trọng số sẽ cho phép khác hàng xây dựng cây ưu tiên thể hiện cách khách hàng muốn nhận các tùy chọn. Server sẽ sử dụng thông tin để ưu tiên xử lý luồng và kiểm soát tài nguyên hệ thống như CPU, bộ nhớ và các tài nguyên khác, sau khi có phản hồi nó sẽ phân bổ băng thông để đảm bảo cung cáp các phản hồi ưu tiên cao cho khách hàng. ---<> đẩy nhanh thời gian tải của trang.

3. Header Compression: Mỗi HTTP transfer mang theo một tập các headers mà sẽ định nghĩa tài nguyên vận chuyển và tính chất của nó. Trong HTTP1.1 tất cả header value sẽ  phải chuyển trong một plain-text format mà sẽ cần 500-800 byte mỗi request, kích thước này sẽ tăng lên nếu HTTP cookies được sử dụng. HTTP2 cung cấp một giải pháp tốt hơn cho việc vận chuyển này bằng cách sử dụng HPACK compression format sử dụng công nghệ bên dưới:
		- Nó cho phép việc vận chuyển các trường trong header đưuọc encode thoogn quan một Huffman code, giảm transfer size.
		- Nó đồng thời yêu cầu cả server và client duy trì và cập nhật danh sách của các trường header đã được gửi trước đó ---> bỏ qua trùng lặp

4. Server Push: Server will push all dependent resources which are not requested the client.
5. Flow control: 
	- Kiểm soát luồng là cơ chế để ngăn ngừa người gửi tràn ngập dữ liệu đến người nhận.
	- HTTP2 giải quyết bằng cách cung cấp receive window thông gáo kích thước truyền dữ liệu giữa người gửi và người nhận. 
		+Khi kết nối được thiết lập lần đầu tiên, nó sẽ sử dụng các cài đặt mặc định. 
	 + Nếu máy chủ đang truyền một lượng lớn dữ liệu đến máy khách trong trường hợp cửa sổ tải xuống máy khách nhận được có thể trở thành yếu tố giới hạn, tương tự trong trường hợp máy khách gửi một lượng lớn dữ liệu đến máy chủ, trong trường hợp này, cửa sổ nhận máy chủ sẽ được yếu tố hạn chế.
	 + Trong mọi trường hợp, một cửa sổ nhỏ hơn sẽ là một yếu tố hạn chế.

6. ALPN
Cho TLS (transport layer security) có thể sử dụng ALPN (Application-Layer Protocol Negotiation). ALPN cho phép TLS  connection có thể đảm phán application level protocol sẽ được chạy qua nó.
Sau khi hình thành một HTTP2 connenction mối endpoint phải gửi một connection preface như xác nhận cuối cùng và để hình htnafh một tiền settings cho HTTP2. C

To test Akka HTTP2:

cd /root/lamtv10/ssl
java  -javaagent:./jetty-alpn-agent-2.0.9.jar -cp "./lib/*.jar:AkkaServer.jar"  -DnumberThread=1 -DpoolSize=10 akkaserver.Http2JavaServerTest  9001

test client:
Install curl with http2: https://takeshiyako.blogspot.com/2015/09/curl-http2.html
cd /root/curl
./src/curl -k -v https://controller:9001


Check ALPN and JDK https://www.eclipse.org/jetty/documentation/current/alpn-chapter.html#alpn-openjdk8




7. IntelJ do JDK 9 ko dc ho tro o Netbean
java 11:
vim ~/.bashrc 
# added by Anaconda3 installer
export PATH="/home/vttek/anaconda3/bin:$PATH"
export JAVA_HOME=/home/vttek/jdk-11.0.1
export PATH=$JAVA_HOME/bin:$PATH


 1986  scp -r vttek@172.16.25.177:jdk-11.0.1
 1987  scp vttek@172.16.25.177:jdk-11.0.1
 1988  scp vttek@172.16.25.177:/home/vttek/jdk-11.0.1
 1989  scp vttek@172.16.25.177:/home/vttek/jdk-11.0.1 /home/vttek/
 1990  scp -r vttek@172.16.25.177:/home/vttek/jdk-11.0.1 /home/vttek/
 1991  cd
 1992  sudo gedit ~/.bashrc
 1993  source gedit ~/.bashrc
 1994  source  ~/.bashrc
 1995  java -version
 1996  clear
 1997  java -version
 1998  gedit ~/.bashrc


vttek@ubuntu:~/idea-IU-181.5087.20/bin$ ./idea.sh

8. https://alvinalexander.com/java/java-keytool-keystore-certificates
java keytool:

openssl pkcs12 -export -keypbe PBE-SHA1-3DES -certpbe PBE-SHA1-3DES -export -in server_cert.pem -inkey private_key.pem -name akka -out keystore.p12

java  -javaagent:./jetty-alpn-agent-2.0.9.jar -cp "./lib/*.jar:AkkaServer.jar"  -DnumberThread=1 -DpoolSize=10 akkaserver.Http2JavaServerTest  9001 
/*bin/keytool -import -v -trustcacerts -alias controller -file server -keystore cacerts.jks -keypass changeit -storepass changeit*/
./bin/keytool -import -v -trustcacerts -alias jetty -file cacert.crt -keystore  jre/lib/security/cacerts   -keypass changeit -storepass changeit



9. Standardized HTTP Client API
- HttpClient: su dung de gui request va nhan response, ho tro gui ca synchronously va asynchronously vang cach dung method send, sendAsync. De tao mot instance, mot Builder duoc cung cap. Mot khi duoc tao instance nay la bat bien
- HttpRequest: dong goi mot Http Request bao gom ca URI, method GET POST, header va cac thong tin khac. Mot request duoc xay dung bang builder la khong doi moi lan create, co the gui nhieu lan
- HttpRequest.BodyPublisher: Neu mot Request co body (vi du POST ) cai nay se la dai dien cho publishing body content tuw mot given source , vi du tu string 
- HttpResponse: Dong goi mot HTTP Resonse bao gom ca header va message body neu co. Day la cai ma client nahn 
- HttpResponse.BodyHandler: Mot interface chap nhan thong tin ve response (satatus code va header )
- HttpResponse.BodySubscriber:  Dang ky cho response body va tieu thu no thanh dang khac vi du (string, file)


/root/lamtv10/bin/java   -Xbootclasspath/p:alpn-boot-8.1.12.v20180117.jar -cp "./lib/*.jar:JavaJettyHttp2.jar"  -DnumberThread=1 -DpoolSize=10 server.Http2Server  9001

10. Jetty HTTP2:
- gen key:
$ openssl genrsa -aes128 -out jetty.key
			--> jetty.key
VN - HaNoi - HaNoi - Viettel - OCS - *.jetty
			-
$ openssl req -new -x509 -newkey rsa:2048 -sha256 -key jetty.key -out jetty.crt
			---> jetty.crt



$ openssl req -new -key jetty.key -out jetty.csr
			---> jetty.csr


$ keytool -keystore keystore -import -alias jetty -file jetty.crt -trustcacerts
			--->loads a PEM encoded certificate in the jetty.crt file into a JSSE keystore:


$ openssl pkcs12 -inkey jetty.key -in jetty.crt -export -out jetty.pkcs12
			----> combines the keys in jetty.key and the certificate in the jetty.crt file into the jetty.pkcs12 file

$  keytool -importkeystore -srckeystore jetty.pkcs12 -srcstoretype PKCS12 -destkeystore keystore		


$ 





11. Jetty Handle: 
	- HandlerCollection: Chua mot tap handler va goi chung theo thu tu lan luot. --> Thuong duoc su dung cho ket hop stattistic va logging handler voi hand ler sinh responses.
	- Handler List: la mot handlercollection goi mot hanle theo turn cho den khi mot trong so chung bi exception, response commited hoac request.isHandled() tra ve true. --> Su dung de ket hop handler dat dieu kien handle mot requeset 
	- HandlerWrapper: Một lớp cơ sở Handler mà bạn có thể sử dụng để xử lý chuỗi daisy với nhau theo kiểu lập trình hướng theo khía cạnh. Ví dụ, một ứng dụng web tiêu chuẩn được triển khai bởi một chuỗi các trình xử lý bối cảnh, phiên, bảo mật và servlet.
	- ContextHandlerCollection: Mot tap Handler su dung request URI de chon contained ContextHandler se handle request 

	Scoped Handlers: 
	- Server.handle(...)
  ContextHandler.doScope(...)
    ServletHandler.doScope(...)
      ContextHandler.doHandle(...)
        ServletHandler.doHandle(...)
          SomeServlet.service(...)


    Resource Handler: 
     server.addConnector(http);

        // Set a handler
        server.setHandler(new HelloHandler());

        // Start the server
        server.start();
        server.join();

12 Embedding Servlets:
	Servlets la con duong co ban nhat de cung cap application logic handles HTTP requests. Servlets tuong tu nhu Jetty Handler tru viec request object khong mutable va do do co the modified, Servlets duoc xu ly trong Jetty boi mot ServletHandler. 

	Embedding Contexts:
	Mot ContextHandler la mot ScopedHandler chi tra loi tu request co URI prefix match voi config context path. Request match context path co path method updated dua tren va context scope kha dung:
		- Mot Classloader gom tap cac Thread context Classloader khi request handling trong scope
		- Mot tap cac thuoc tinh ma kha dung thong qua ServerletContext API
		- Mot tap cac parameters kha dung thong qua ..
		- Mot base resource duoc su dung nhu la document root cho static resource request thong qua ServerletContext API 
		- Mot tap cac virtual host name
 	ContextHandler context = new ContextHandler();
        context.setContextPath("/hello");
        context.setHandler(new HelloHandler());

        // Can be accessed using http://localhost:8080/hello

        server.setHandler(context);


13. Secure Hello Handler:


14. Non-Blocking APIS 
- De xu ly blocking sytle: thread xu ly request block cho den khi request hoac response duoc hoan tat.
- Voi non-blocking: async API cuc tot cho bai toan large content download, cho xu ly song song va cho truong hop hieu nang va hieu qua cua thread va phan phoi tai nguyen la key factor.]


	+ Co mot listener thuc hien request va response processing, listener nay duoc implemented boi app va co the thuc thi moi loai logic. 
	+ 
Nếu bạn cần thực thi mã ứng dụng mất nhiều thời gian bên trong trình nghe, bạn phải sinh ra luồng của riêng mình và nhớ sao chép sâu bất kỳ dữ liệu nào do người nghe cung cấp mà bạn sẽ cần trong mã của mình, bởi vì khi người nghe trả về dữ liệu mà nó cung cấp có thể được tái chế / xóa / phá hủy.



+ httpClient.newRequest("http://domain.com/path")
        .send(new Response.CompleteListener()
        {
            @Override
            public void onComplete(Result result)
            {
                // Your logic here
            }
        });



15. HTTP Client
Cach don gian nhat de thuc hien HTTP request la:
	ContentResponse response = httpClient.GET("http://domain.com/path?query");
// thuc hien method GET va tra ve ContentResponse khi request hoac response duoc hoan tat.
	ContentResponse chua thong tin HTTP: status code, headers, possibly content.(content length bi limit boi default la 2MB)
	Ngoai ra bo xung nhu sau:
		Request request = httpClient.newRequest("http://domain.com/path?query");
		request.method(HttpMethod.HEAD);
		request.agent("Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:17.0) Gecko/20100101 Firefox/17.0");
		ContentResponse response = request.send()


POST nhu sau:
	ContentResponse response = httpClient.POST("http://domain.com//entity/1")
				.param("p", "value")
				.send()


Request va response duoc xu ly boi 2 thread khac nhau va do do co the xay ra dong thoi. Mot vi du cho viec nay la echo server khi larger upload co the dong thoi voi large download echo back. 

Nhac nho, nho rang response co the duoc xu ly va hoan tat truoc ca request, mot vi du la mot large uplpad dua ra mot response nhanh (vi du error) ---> response tra ve truoc ca khi request hoan tat.
 
Request.send(Response.CompleteListener) thuc thi xu ly request cho den khi request dduco thuc thi hoan toan hoac no bi block tren I/O sau do return. Neu no bi block I/O thread hoi IO system de emit mot event khi I/O san sang tiep tuc sau do tra ve.  Khi event is fired, mot thread nhan tu HttpClient thread pool se tiep tuc xu ly rewust.


	
Response dang duoc thuc thi tu I/O thread fires event that byte dang san sang cho viec doc. Response xu ly tiep tuc cho den khi dong thoi response duoc hoan tat hoat cho den khi no bi block cho I/O. KHi mot event is fired, mot thread nhan tu HttpClinet thread pool se resum e pro.



Khi request va response dong thoi duoc xu ly hoan tat thi mot thread se lam not cong viec cuoi cung. la dequeue next request cho cung destination va thuc thi no.



16 Respone Content Handing:

Jetty HTTP Client cho phep applicaiton handle response content trong mot so cacch khac nhau: 
	 - Buffer content trong memory ---> su dung blocking APIs va content sex duoc buffre ben trong ContentResponse toi 2MB
	 - Su dung BufferingResponseListener utility class : httpClient. newRequest("http://domain.com/path").send(new BufferingResponseListener(8*1024*1024){ public void onComplete()})

	 - Cach lam thu 2 hieu qua hon vi tranh duoc content copies va cho phep ban chi dinh Response.ContentListener hoac mot subclass de handle content moi khi no duoc chuyen toi. Trong vi du ben duoi: Response.Listener.Adapter la mot class implement ca Response.ContentListener va Response.CompleteListener va co the passed toi Request.send(). Jetty Http client se invoke onContent() method va cuoi cung goi vao method onComplete()


	 httpClient.newRequest("http://domain.com/path").send(new Response.Listener.Adapter() {   public void onContent()})


17. Cookies Support:
	Jetty HTTP Client ho tro cookie. HttpClient instance nhan cookie tu HTTP response va luu chung vao java.net.CookieStore, mot class la mot phan cua JDK. Khi request moi duoc tao cookie da luu duoc loi ra va neu co matching cookie (chua expired va match domain voi mot phan cua request) thi se duoc them vao request. 


	CookieStore cookiestore = httpClient.getCookieStore()





	Neu muon tat cookie Handling thi ban co the cai dat HttpCookieStore.Empty instance theo cach sau:
		- httpClient.setCookieStore(new HttpCookieStore.Empty());



18. Provided Servlets, Filters, Handlers
Classname: org.eclipse.jetty.servlet.DefaultServlet
	+acceptRanges
	+ dirAllowed
	+ redirectWelcome
	+ welcomeServlets
	+ precompressed
	+ gzip 
	+ resourceBase
	+ resourceCache
	+ relativeResourceBase
	+ cacheControl
	+ maxCacheSize
	+ maxCachedFile
	+ useFileMappedBuffer

Proxy Servlet:
	+ hostHeader
	+ viaHost
	+ whiteList
	+ blackList
	-->
	+ maxThreads
	+ maxConnections
	+ idleTimeout
	+ timeout 
	+ requestBufferSize
	+ responseBufferSize

19 Optimizing Jetty 
	+ Garbage Collection: 
	Điều chỉnh bộ sưu tập rác JVM (GC) có thể cải thiện đáng kể hiệu năng của JVM nơi Jetty và ứng dụng của bạn đang chạy. Điều chỉnh tối ưu của GC phụ thuộc vào hành vi của (các) ứng dụng và yêu cầu phân tích chi tiết, nhưng có những khuyến nghị chung cần tuân theo để có được ít nhất các bản ghi GC toàn diện có thể được phân tích sau này.

	GC Logging Configuration:
		-Xloggc:/path/to/myjettybase/logs/gc.log
		-XX:+PrintGCDateStamps
		-XX:+PrintGCDetails
		-XX:+ParallelRefProcEnabled
		-XX:+PrintReferenceGC
		-XX:+PrintTenuringDistribution
		-XX:+PrintAdaptiveSizePolicy


	+ High Load 
	Cau hinh Jetty cho high load, yeu cau os, jvm, jetty, app, network va load generation tat ca tuned 
	Load Generation for Load Testing:
		- Van de khi gui tuong doi it ket noi trong khi gui cang nhieu yeu cau qua moi ket noi cang tot. 
	Operating System Tuning: 
		Linux: 

		TCP Buffer Size: Tang TCP buffer size toi 16MB cho 10G path va bat auto-tunning:
			$ sysctl -w net.core.rmem_max=16777216
			$ sysctl -w net.core.wmem_max=16777216
			$ sysctl -w net.ipv4.tcp_rmem="4096 87380 16777216"
			$ sysctl -w net.ipv4.tcp_wmem="4096 16384 16777216"

		Queue size: 
			mac dinh la 128, neu chay high-volume server va ket noi bi refused tai TCP server thi can tang gia tri nay len. --- > tuy nhien neu set qua cao se dan den resource problem xuat hien nhu viec no co gang thong bao server ve nhieu ket noi va nhieu pending, nhung set qua thap thi lai lam cho refused  connection occur

		sysctl -w net.core.somaxconn=4096

		net.core.netdev_max_backlog dieu khien kich thuoc cua goi tin den queu cho upper-layer java processing. Gia tri mac dinh 2048 co the tang va cac gia tri lein quan theo cach sau 
		$ sysctl -w net.core.netdev_max_backlog=16384
		$ sysctl -w net.ipv4.tcp_max_syn_backlog=8192
		$ sysctl -w net.ipv4.tcp_syncookies=1

		Ports: 
			Tang port range va cho phep reuse socket trong TIME_WAIT 


		File Descriptors:
			Tang kich thuoc file descriptor cho mot user cu the bang cach : /etc/security/limits.conf: theusername	hard 	nofile 40000

		Congestion Control: 
	+ Limit Load
	<Configure id="Server" class="org.eclipse.jetty.server.Server">
  <Call name="addBean">
    <Arg>
      <New id="lowResourceMonitor" class="org.eclipse.jetty.server.LowResourceMonitor">
        <Arg name="server"><Ref refid='Server'/></Arg>
        <Set name="period"><Property name="jetty.lowresources.period" deprecated="lowresources.period" default="1000"/></Set>
        <Set name="lowResourcesIdleTimeout"><Property name="jetty.lowresources.idleTimeout" deprecated="lowresources.lowResourcesIdleTimeout" default="1000"/></Set>
        <Set name="monitorThreads"><Property name="jetty.lowresources.monitorThreads" deprecated="lowresources.monitorThreads" default="true"/></Set>
        <Set name="maxConnections"><Property name="jetty.lowresources.maxConnections" deprecated="lowresources.maxConnections" default="0"/></Set>
        <Set name="maxMemory"><Property name="jetty.lowresources.maxMemory" deprecated="lowresources.maxMemory" default="0"/></Set>
        <Set name="maxLowResourcesTime"><Property name="jetty.lowresources.maxLowResourcesTime" deprecated="lowresources.maxLowResourcesTime" default="5000"/></Set>
        <Set name="acceptingInLowResources"><Property name="jetty.lowresources.accepting" default="true"/></Set>
      </New>
    </Arg>
  </Call>
</Configure>




