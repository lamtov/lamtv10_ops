The CI server notices the change and starts running through its pipeline. The pipeline would be configured to perform both Continuous Integration and Continuous delivery tasks.


Unit Testing: 
	- Một Core Java Library and a Sandboxed runtime will be created ==> chạy ngay trong 1 docker image có sẵn ,,,,
	- Dev can now push events to  any stream of app and consume events produced in any stream

Integration Testing: 
	- As the purpose of the integration test is to verify how the application behaves with other systems within the whole solution stack, such as with databases, message brokers, backend services, and so on
	- Start production-ready package of Siddhi app
	- Start instance of each dependent system 
	- Run test by interacting only via the public service endpoints with the siddhi app
	- Allocating resources only at test execution and decommissioning them when the tests are done.



	==> sử dụng docker + service
Continuous Deployment
Continuous Deployment can be validated through the black-box tests. The process of writing these tests for Siddhi is discussed below.
Black-box Testing and in this case, instead of spawning dependent modules, it configuring the Siddhi Runner instance to communicate with the actual systems in the environment.
	the setUpCluster() method configures the infrastructure for the tests to run
	==> sử dụng kubernetes 



	functional
	performance
	code error



Deploying Siddhi CI/CD pipelines in a Kubernetes cluster

http://www.scmgalaxy.com/tutorials/top-10-continuous-integration-tool/
https://blog.vietnamlab.vn/2019/08/04/tu-developer-den-devops-engineer/



- FUll hệ thống:
	Kubernetes: Auto Review Apps, Auto Deploy, Auto Monitoring
	Gitlab Runner: For All Stages
	Prometheus: Monitoring 








- Auto Build: build application using Dockerfile or Heroku buildpacks, ket qua build se duoc gui vao container registry voi commit SHA hoac tag 
- Auto Build using a Dockerfile
- Auto Build using Heroku buildpacks
- Auto Test
- Auto Code Quality
- Auto SAST
- Auto Dependency Scanning
- Auto License Compliance
- Auto Container Scanning
- Auto Review Apps
- Auto DAST
- Auto Browser Performance Testing
- Auto Deploy
- Auto Monitoring


https://docs.gitlab.com/ee/topics/autodevops/#kubernetes-116


- Sử dụng docker 
image: docker:19.03.1

variables:
  # When using dind service we need to instruct docker, to talk with the
  # daemon started inside of the service. The daemon is available with
  # a network connection instead of the default /var/run/docker.sock socket.
  #
  # The 'docker' hostname is the alias of the service container as described at
  # https://docs.gitlab.com/ee/ci/docker/using_docker_images.html#accessing-the-services
  #
  # Note that if you're using GitLab Runner 12.7 or earlier with the Kubernetes executor and Kubernetes 1.6 or earlier,
  # the variable must be set to tcp://localhost:2375 because of how the
  # Kubernetes executor connects services to the job container
  # DOCKER_HOST: tcp://localhost:2375
  #
  DOCKER_HOST: tcp://docker:2375
  #
  # This will instruct Docker not to start over TLS.
  DOCKER_TLS_CERTDIR: ""

services:
  - docker:19.03.1-dind

before_script:
  - docker info

build:
  stage: build
  script:
    - docker build -t my-docker-image .
    - docker run my-docker-image /script/to/run/tests

==> build 1 image test lên và chạy test 
==> Dùng docker-compose nếu cần 

còn app thì vẫn build truyền thống 

Câu hỏi: 2 người cùng submit 

file:///C:/Users/Administrator/Downloads/nemytchenko-161029154729.pdf
Requirement #2
Package code before sending it to customer
	Sử dụng artifacts:
		artifacts:
			paths:
			- packaged.gz 


Make results of your build downloadable
Run jobs sequentially
Speeding up the build: Sử dụng artifacts

Requirement #3
ISO instead of GZIP

Requirement #5
Two developers on the project
	Su dung only: - master 

Requirement #6
Need a separate place
 for testing

s3:
 image: python
 stage: deploy
 script:
 - pip install awscli
 - aws s3 cp ./ s3://yourbucket/ --recursive
 only:
 - master
pages:
 image: alpine
 stage: deploy
 script:
 - mkdir -p ./public && cp ./*.* ./public/
 artifacts:
 paths:
 - public
 except:
 - master
 
Using Environments



==> Ansible + Kubernetes





Build
Test 
	- code_quality
	- container_scannign
	- dependency_scannign
	- license_management
	- SAST
	- test 
Review 
DAST
Performance
cleanup 







VD1: dùng chung nhiều file xml
VD2: dùng chung nhiều lib jar --> update tuần tự lỗi 
VD3: Dùng chung cấu hình ở Mysql --> cập nhật bất đồng bộ 
https://gitlab.com/williamchia/cncf-demo-1/-/blob/master/README.md


Environment chủ yếu dùng cho trương hợp deployment và rollback (deployment lỗi abc ,,,, ---> chọn version to rollback abc,,,,)

==> big problem with kubernetes free abc dsdfsfsdfdsfsfsdfsdfsdfsdfsdfsd



===> cài hết service của các anh lên docker 

https://docs.gitlab.com/runner/executors/kubernetes.html

==> run kubectl tiện hơn,.... rollback, ...