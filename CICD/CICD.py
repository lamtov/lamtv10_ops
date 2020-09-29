https://gist.github.com/andreicristianpetcu/b892338de279af9dac067891579cad7d
https://www.youtube.com/watch?v=TWxKD9dLpmk&list=PLOspHqNVtKAAm1dmyiR9WMmw1UBoOwZVj&index=17

https://testing.googleblog.com/
https://testing.googleblog.com/2015/04/just-say-no-to-more-end-to-end-tests.html

https://www.youtube.com/watch?v=Zl5CWTgUtPE




CI/CD
CI là Continuous Integration là phương pháp phát triển phần mềm yêu cầu các thành viên của team tích hợp công việc của họ thường xuyên, mỗi ngày ít nhất một lần. Mỗi tích hợp được build tự động (bao gồm cả test) nhằm phát hiện lỗi nhanh nhất có thể. Cả team nhận thấy rằng cách tiếp cận này giảm thiểu vấn đề tích hợp và cho vấn đề phát triển phần mềm nhanh hơn.


Kiến trúc:
	- laptop dev 
	- control repository (github)
	- CI server Integration build machine 
	- feedback mechanism 

Kịch bản:
	- dev commit code lên repository
	- CI server giám sát repo và kiểm tra xem có thay đổi nào ko 
	- CI server nhận code mới và build, chạy unit và Integration test ==> giảm thiểu những quy trình thủ công lặp đi lặp lại (build css, js, migrate, test...) thay vào đó là build tự động, chạy test tự động.
	- CI server sẽ sinh feedback và gửi tới các member của project

===> CI là quy trình để build và test tự động 

CD là Continuous Delivery nâng cao hơn một chút bằng cách triển khai tất cả các thay đổi về code (đã được build và test) đến môi trường testing hoặc staging. CD cho phép dev từ dộng hóa phần test bên cạnh việc sử dụng unit test, kiểm tra phần mềm qua nhiều thước đo trước khi triển khai cho production. 
Gồm có UI testing, load testing, Integration testing, API testing...  ===> Tự động hoàn toàn quy trình release phần mềm 

workflow:
	- Development (local environment)
	- staging (pre-production)
	- production (live)





-test:
	+ unit tests: Test chỉ chạy bên trong một process mà không có external dependencies
	+ integration tests: Test chạy với phiên bản giả hoặc thu nhỏ của hệ thống bên ngoài
	+ black-box tests: Ryn in production-like environment 

Siddhi Test Framework:
 + Đơn giản hóa việc implement CI/CD pipeline: giảm thiểu effort và việc viết code
 + STF implement form base TestNG có đủ prewritten components để giúp developer implement unit, integration and black-bõ test for there Siddhi Apps 


 Yêu cầu:
 	+ developer tạo một Siddhi Runtime Docker 
 	+ CI/CD pipeline configured to perform both Continuous Integration and Continuous Delivery tasks.
 	+ Như một phần của CI, pipeline sẽ run unit test bằng cách cahyj Siddhi Application độc lập, thực hiện integration test bằng cách chạy application and dependent service như Docker container để đảm bảo rằng updated siddhi app funtion as expect 
 	+ Sau đó trong CD: CI server request Kubernet cluster để triển khai production-like environment và run black-box test thêm lần nữa bằng việc cho giao tiếp với các dependent service trong environment. 


 	+ Trong giai đoạn CI: Siddhi được sử dụng trong embedded sandbox mode để đảm bảo không có network connections hoặc external dependencies được yêu cầu. 
 	+ Siddhi app được chuyển tới Siddhi Core Java library và một sandboxed runtime sẽ được tạo. Nó chạy app mà không có bất kỳ kết nối nào tới external sources hoặc sinks, tất  cả external data được convert thành in-memory tables. 

 Integration Testing:
 	Mục đích của Integration Test là để verify làm cách nào application giao tiếp với những hệ thống khác bên trong toàn bộ solution stack như là database, message brokers, backend services... Iteraction giữa các hệ thống đó có thể chỉ tested được bởi chạy tất cả chúng next to each other:
 	- Start a production-ready packages of Siddhi app 
 	- Start an instance of each dependent system 
 	- Run tests by interacting only via the public service endpoints with the Siddhi app. 
 	- Not preserving data between tests, such that we dont have to worry about restoring to the initial state before each test.
 	- Allocating resources only at test execution and decommissioning them when the tests are done. 


 Base On: TestContainers  + TestNG


 Quy trình CI/CD tham khảo trong hệ thống Teamcrop:
 - Bước 1: KHởi tạo repository và có branch default là master và dev cài đặt trên GITLAB9
 - Bước 2: Coder push tính năng lên branch dev 
 - Bước 3: Hệ thống tự động test source code, nếu PASS thì sẽ deploy tự động (rsync) code lên server beta 
 - Bước 4: Tester/QA vào hệ thống để làm UAT (User Acceptance Testing) và confirm là mọi thứ OK 
 - Bước 5: Owner tạo Merge Request và merge từ branch dev sang branch master 
 - Bước 6: Hệ thống tự động thực hiện test source code, nếu PASS sẽ enable tính năng cho phép deploy lên production server 
 - Bước 7: Review là Merge request OK, test OK nhấn deploy để áp thay đổi lên môi trường production. 
 - Bước 8: Tester và production làm UAT và confirm là OK 

 Gitlab-ci.yml
https://docs.gitlab.com/ce/ci/yaml/
File này có một số section để khai báo như trước khi chạy test thì làm gì, khi test thì dùng lệnh gì (ví dụ chạy linter check cú pháp, chạy PHPUnit test...) test xong rồi thì thực hiện deploy đi đâu (beta, production...) với câu lệnh gì (ví dụ rsync...)
Gitlab Runner: 
Là thành phần quan trọng trong workflow Gitlab CI. Nếu không có Runner thì sẽ không có lệnh test, deploy nào được thực thi, Runner có nhiều loại, phân biệt bằng executor. Khi khởi tạo runner bạn sẽ quyết định loại executor nào, nó sẽ quyết định môi trường thực thi các câu lệnh trong file config ở trên. 



docker run --detach \
    --publish 5432:80 --publish 2222:22 \
    --name gitlab9 \
    --restart=always \
    --env GITLAB_OMNIBUS_CONFIG="external_url 'http://gitlab.ocs.com/';" \
    --volume /gitlab9/config:/etc/gitlab \
    --volume /gitlab9/logs:/var/log/gitlab \
    --volume /gitlab9/data:/var/opt/gitlab \
    gitlab/gitlab-ce:9.0.3-ce.0

docker run -d --name gitlab-runner --restart always \
  -v /srv/gitlab-runner/config:/etc/gitlab-runner \
  -v /var/run/docker.sock:/var/run/docker.sock \
  gitlab/gitlab-runner:latest

ví dụ 172.16.29.193:5432/ci
Một Runner là một process runs một job. Có thể setup bao nhiêu runners tùy thích, runner có thể đặt trên các users, server khác nhau thậm chí trên localmachine.
Mỗi runner có 2 trạng thái:
	- active: Runner is active and can process any new jobs 
	- paused: Runner is paused and will not receive any new jobs 


docker run --rm -t -i -v /srv/gitlab-runner/config:/etc/gitlab-runner gitlab/gitlab-runner register


Gitlab CI/CD có một tập các predefined variables thứ mà có thể sử dụng không cần specification nào. Có thể gọi issues numbers, user names, branch names, pipeline and commit IDs, ...
Predefined environment variables ==	vs ======= local environment 
Gitlab đọc .gitlab-ci.yml file, gửi information tới Runner (nơi run script commands) 
		+ chạy unit test để đảm bảo mọi thay đổi không làm break các phần code còn lại 
		+ mọi push triggers multiple tests, làm nó dễ dàng hơn để xác thực lỗi ở đâu và khi nào một test fail
		+ 





https://about.gitlab.com/blog/2016/07/22/building-our-web-app-on-gitlab-ci/
Reliable dockerized builds vs jenkin builds all executed on a resource-contrained server 



openssl genrsa -out "/etc/pki/tls/private/gitlab-registry.key" 4096
288 openssl req -x509 -sha512 -nodes -newkey rsa:4096 -days 730 -keyout /etc/pki/tls/private/gitlab-registry.key -out /etc/pki/tls/certs/gitlab-registry.crt
289 ll /etc/ssl/certs/
290 ll /etc/pki/tls/certs/gitlab-registry.crt
291 cd /srv/gitlab
292 ll
293 cd config/
294 ll
295 docker ps
296 docker ps -a
297 docker rm gitlab
298 vim /srv/gitlab/config/gitlab.rb
299 mkdir /srv/gitlab/ssl
300 cp /etc/pki/tls/private/gitlab-registry.key /srv/gitlab/ssl/gitlab.key
301 cp /etc/ssl/certs/gitlab-registry.crt /srv/gitlab/ssl/gitlab.key
302 cp /etc/ssl/certs/gitlab-registry.crt /srv/gitlab/ssl/gitlab.crt
303 ll /srv/gitlab/ssl/gitlab.
304 ll /srv/gitlab/ssl/gitlab.crt
305 vim /srv/gitlab/config/gitlab.rb
306 cd /srv/gitlab
307 ll
308 mv ssl/ config/
309 ll config/
310 docker run --detach --hostname gitlab.ocs.com --publish 443:443 --publish 5432:80 --publish 2222:22 --name gitlab --restart always --volume /srv/gitlab/config:/etc/gitlab --volume /srv/gitlab/logs:/var/log/gitlab --volume /srv/gitlab/data:/var/opt/gitlab gitlab/gitlab-ce:latest
311 docker ps
312 curl https://gitlab.ocs.com
313 curl -k https://gitlab.ocs.com

