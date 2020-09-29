
Zipkin vs Jaeger 
Request tracing truy ra hoạt động bên trong và thông qua các hệ thống khác nhau. Hay nói cách khác nó cho phép kỹ sư nhìn thấy thời gian bao lâu một hoạt động được nhận trong một web server, database, app code hoặc toàn bộ hệ thống, tất cả được trình bày trên một timeline. Request tracing đặc biệt giá trị trong hệ thống phân tán khi mà các giao dịch đơn lẻ như (create account) thông qua nhiều hệ thống.

Request tracing hỗ trợ với logs và metric. Một trace sẽ chỉ ra được khi một flow bị broken hoặc bị chậm cùng với độ trễ của mỗi step. Tuy nhiên trace không giải thích vì sao trễ hoặc error. Logs có thể giải thích vì sao thế. Metrci cho phép phân tích sâu vào trong system faults.
Traces đồng thời là đặc trưng cho một thao tác duy nhất, chúng không có tính tổng hợp như logs hoặc metric.
===> Cần cả 3 để có thể deug và giải quyết vấn đề. 

Các đội bắt đầu với việc ghi nhật ký và giám sát, sau đó thêm dấu vết khi có nhu cầu. Điều này là do không có giải pháp thả xuống. Các nhóm kỹ thuật phải sử dụng mã, thêm dấu vết cho các thành phần cơ sở hạ tầng như bộ cân bằng tải và tự triển khai hệ thống theo dõi. Giải pháp phải có yếu tố hỗ trợ ngôn ngữ và thư viện, hoạt động sản xuất và hỗ trợ cộng đồng. Bài đăng này chuẩn bị cho bạn quyết định đó bằng cách đánh giá Zipkin và Jaeger.


Zipkin																		vs 															Jaeger
Zipkin ban đầu được lấy cảm hứng từ Dapper và được phát triển bởi Twitter    |  Jaeger ban đầu được xây dựng và mở nguồn bởi Uber.

Các hệ thống thiết bị gửi các sự kiện / dấu vết đến trace collector. Collector ghi lại dữ liệu và mối quan hệ giữa các dấu vết. Tracing system cũng cung cấp một giao diện người dùng để kiểm tra dấu vết.

Ví dụ với Jaeger: thành phần của nó gồm: 
	+ Implement Opentracing API tạo spans khi nhận được một request mới. 
	+ Jaeger Agents đại diện cho Listening cho spans và gửi chúng tới Collector.
	+ Collector nhận traces từ agents và chạy chúng thông qua một pipeline xử lý với kết thúc bằng việc lưu chúng vào backend storage.







Language Support


		Zipkin	Jaeger
C++		Unofficial	Official
C#		Official	Official
Go		Official	Official
Java	Official	Official
Python	Unofficial	Official
Ruby	Official	Unofficial
Scala	Official	Unofficial (or use the Java library)
Node.js	Official	Official
PHP		Unofficial	Unofficial



Both Zipkin and Jaeger support multiple storage backends such as Cassandra or Elasticsearch


==============================================================================>
Implementing OpenTracing with Jaeger
Trong kiến trúc microservice một ứng dụng nguyên khối được chia nhỏ thành một nhóm các dịch vụ triển khai độc lập. Khi có cả triệu microservice hoạt động đan xen cùng nhau sẽ gần như là không thể để nối các service độc lập này và hiểu luồn thực thi các request
Trong trường hợp thất bại trong một ứng dụng nguyên khối, việc hiểu đường dẫn của giao dịch sẽ dễ dàng hơn nhiều và thực hiện phân tích nguyên nhân gốc với sự trợ giúp của các log. Nhưng trong một kiến trúc microservice, log một mình không cung cấp hình ảnh hoàn chỉnh.
		- Đây có phải service đầu tiên trong chuỗi cuộc gọi
		- Làm cách nào để tôi mở rộng tất cả dịch vụ này để hiểu rõ hơn về ứng dụng 
		- Việc gỡ lỗi một tập các dịch vụ phân tán phụ thuộc lẫn nhau trở thành vấn đề lớn hơn đáng kể so với một ứng dụng nguyên khối duy nhất.
Truy tìm phân tán là một phương pháp được sử dụng để lập hồ sơ và giám sát các ứng dụng, đặc biệt là các ứng dụng được xây dựng bằng kiến trúc microservice.

jaeger:
https://medium.com/velotio-perspectives/a-comprehensive-tutorial-to-implementing-opentracing-with-jaeger-a01752e1a8ce
	- Distributed transaction monitoring (Giám sát các giao dịch phân tán)
	- Hiệu năng và tối ưu hóa độ trễ 
	- Root cause analysis 
	- Service dependency analysis (Phân tích sự phụ thuộc của các dịch vụ)
	- Distributed context propagation 

Thành phần trong Jaeger:
	- Agent: Network daemon lắng nghe spans và gửi tới collector. Được thiết kế để triển khai trên tất cả các host như một infrastructure component (thành phần cơ sở hạ tầng). 
	- Collector: Jaeger collector nhận trace từ agent. Hiện tại pipeline xác định trace, index thực thi chuyển đổi và lưu lại vào Elasticsearch.
	- Query: Là service nhận traces từ storage và host một UI để display chúng.
	- Ingester: Là service đọc từ Kafka topic và viết vào một storage backend (Elasticsearch)


Su dụng
	- Install jaeger-client và trên các host 
	- Chạy jaeger backend: docker run -d -p6831:6831/udp -p16686:16686 jaegertracing/all-in-one:latest
		Check http://localhost:16686/
	- Edit code:
		init_trace
		- def function():
			with tracer.start_span('booking') as span:
        		span.set_tag('Movie', movie)
        		with span_in_context(span):
        	==> root span
       def book_show(showtime_details):
    	with tracer.start_span('BookShow',  child_of=get_current_span()) as span:
        with span_in_context(span):


Jaeger và ELK 
	- Mặc định jaeger lưu data trong Cassandra nhưng đồng thời có thể lưu trong Elasticsearch. Khả năng này nghĩa là users có thể phân tích trace sử dụng toàn bộ năng lực của ELK. 

	===> Sử dụng ELK Stack cho phép user bổ xung thêm truy vấn và khả năng visualization. Dựa trên kiến trúc ELK bạn có thể đồng thời có khả năng lưu trữ trace data cho việc mở rộng khả năng quan sát.
	Ví dụ:

============================================================================>
APM
https://www.elastic.co/blog/distributed-tracing-opentracing-and-elastic-apm

Các service được triển khai trên các ngôn ngữ lập trình khác nhau, cài ở các container riêng lẻ và quản lý bởi các team, tổ chức khác nhau vì vậy để xác định được nguồn gốc của vấn đề (root cause of issues) cũng như tăng tính ổ định và hiệu quả thì cần nhìn được health và performance của diverse service topology.
Distributed Tracing giúp giải quyết 2 vấn đề như sau:
- Latency Tracing: 
	Một user request hoặc transaction có thể đi qua nhiều service khác nhau trong các khoảng thời gian khác nhau. Hiểu được độ trễ của mỗi service trong các runtime environment khác nhau.

- Root cause analysis
 Mọi thứ có thể sinh lỗi với mọi service tại mọi thời điểm. Distributed tracing là một trong số giải pháp quan trọng khi debugging issues trong system



 ELK_APM có thể làm được những việc sau:
 - Monitor software serice và applications trong thời gian thực
 - Tập hợp thông tin hiệu năng như response time cho incoming requests
 - Database queries
 - External HTTP requests.

 Elastic APM distributed tracing cho phép phân tích hiệu năng qua microservice architecture tất cả trong một view. Elastic APM làm được điều này bởi tracing tất cả request từ initial web request tới front end request điều này làm cho việc tìm ra botteleneck throughout dễ dàng và nhanh hơn
 Ví dụ trong hình vẽ là một waterfall view của tất cả transaction từ các service độc lập kết nối tới trace 


 The OpenTracing Specification
 	- The Opentracing Specification định nghĩa một open, vendor-neutral API cho distributed tracing. Nó cũng cho phép developer và chia sẻ lib để cung cấp chức năng theo dõi out of the box. 
 OpenTracing Data Model: 
 	- Một trace đại diện cho một transaction là nó di chuyển trong một distributed system. Nó có thể được coi là một biểu đồ có hướng của Span 
 	- Một span đại dienj cho một đơn vị logic của công việc (có name, start time, duration). Span có thể nested và ordered tới một model relationships. Spans chấp nhận key: value tags, fine-grained, time-stamped, structured logs 
 	- Trace context là một trace information mà đồng hành cùng transaction, bao gồm khi nòa passes service to service trên network hoặc thông qua một message bus. Context bao gồm trace identifier, span identifier và các dữ liệu khác mà tracing system cần để tuyên truyền cho các dịch vụ bên dưới.

============================================================================>
https://www.loggly.com/blog/using-loggly-to-trace-a-sequence-of-events/
Sử dụng loggy để trace một tập các câu log của event:
	- Step1: Thêm một unique identifier 
	- Step2: Search for the unique identifier to trace logs across your stack
	- Step3: Sử dụng Loggly cho Tracing Events.
		+ DO mỗi hệ thống lại có nhiều định dạng log khác nhau để thêm trật tự thì dễ dàng nhất là để chế độ xem lưới cung cấp bố cục cột đẹp mắt ngay lập tức cho thấy sự tiến triển theo thời gian và làm nổi bật các phần có liên quan.
		+ Nhóm các cột lại với nhau theo ứng dụng để thấy luồng giao dịch từ service này tới service khác.
		+ Xắp xếp theo thứ tự tăng dần để có thể thấy trình tự thời gian khi đọc xuống bảng.
			==> Khung cảnh thác nước mỗi bước xử lý xuống và sang phải.
			Nếu giao dịch có callback thì có thể thấy các callback được gọi trở lại vào cuối giao dịch.

---> Cách làm: tạo bảng grid 
	+ Thêm column thời gian, column từng service và fill log vào nếu có log 








	








=========================================================================================================================>


Osprofiler:
from osprofiler import profiler
def some_func():
    profiler.start("point_name", {"any_key": "with_any_value"}) 
    # your code
    profiler.stop({"any_info_about_point": "in_this_dict"})

- Mỗi profiler.start() và profilter.stop gửi tới collector 1 message, điều này nghĩa là mỗi trace point tạo 2 record trong collector.
==> message 
{
	"name": <point_name>-(start|stop)
    "base_id": <uuid>,  là giống nhau cho tất cả tracepont cùng thuộc một trace, dùng để đơn giản hóa quá trình nhận tất cả trace points liên quan đến 1 trace từ collector.
    "parent_id": <uuid>, uuid của parent tracepont 
    "trace_id": <uuid>, uuid của current tracepoint
    "info": <dict> 
}





With decorator

from osprofiler import profiler
@profiler.trace("point_name",
                info={"any_info_about_point": "in_this_dict"}, 
                hide_args=False)



===? nova.conf
[profiler]
enabled = True
trace_sqlalchemy = False
hmac_keys = SECRET_KEY
connection_string = jaeger://127.0.0.1:6831
===> chỉ có ở phiên bản rocky
https://docs.openstack.org/osprofiler/queens/


---------------- Cài đặt collector :
def send_info_to_file_collector(info, context=None):
    with open("traces", "a") as f:
        f.write(json.dumps(info))

==> collector hiện tại chỉ là 1 file 

==> cấu hình [profiler]:






cinder --profile SECRET_KEY create 1
nova --profile SECRET_KEY list 
osprofiler trace show --html <trace_id>



===> Osprofiler at a glance:
- Distributed tracing library for OpenStack projects
- Generates single trace for API request:
			+ Trace element: each method in the trace 
- Generates trace report in different format: HTML, JSON, DOT 
- Trace report includes:
			+ Call hierarchy
			+ Time spent in each method 
			+ Project/Service 
			+ Debugging context 



why osprofiler:
		+ enable hoac disable ma khong restart services 
		+ enable tracing cho specific API request 
		+ Một số lượng nhỏ user có thể enable tracing 
		+ Dễ dàng để tương tác với OpenStack project.


osprofiler components:
		+ Cấu hình OSprofiler Components: once per service initialization.
			cinder/service + cinder/api/web


		+ Initializing profiler (once per API)
			web->profiler->notifier->driver->trace data store.


TRACE ELEMENT:
		+ wsgi_start   : path, query, method, scheme, 
		+ wsgi_stop				
		+ rpc_start				: function name, args, kwargs
		+ rpc_stop 
		+ db_start					: statement, params
		+ db_stop
		+ driver_start
		+ driver_stop

id base_id parent_id 
project --> service --> osapi_volume, cinder_volume, nova-compute ..

name --> wsgi .... 
timestamp 
info --> 
		+ Sending trace ìno


OSprofiler 1.9 supports:
	- ceilometer
	- elastic search 
	- log insight
	- mongo db 
	- redis


Trace Generation:
	- Initialize OSprofiler with secret key and connection string 
	Ví dụ: connection_string = "mongodb://127.0.0.1:27017"
								initializer.init_from_conf(CONF)
		- Patch manager, driver classes:
								manager_class = profiler.trace_cls("rpc")(manager_class)

	- Iniating trace request (in Clients):
	 		+ Neu profile option duoc set, initialize profiler:
	 					profiler.init(secret_key=secret_key)


Method calls:
	- @profiler.trace("driver")


RPC calls:
	- Request context serialization:
	context.update({"trace_info": trace_info})
	- Request context deserialization:
	profiler.init(**trace_info) 






