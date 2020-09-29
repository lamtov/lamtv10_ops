Token: UyPTCZKHqauD2PqxJHHh

before_script:
- export "PATH=$PATH:/vendor/bin"
# Install ssh-agent if not already installed, it is required by Docker.
# (change apt-get to yum if you use a CentOS-based image)
- 'which ssh-agent || ( apt-get update -y && apt-get install openssh-client -y )'

# Run ssh-agent (inside the build environment)
- eval $(ssh-agent -s)

# For Docker builds disable host key checking. Be aware that by adding that
# you are suspectible to man-in-the-middle attacks.
# WARNING: Use this only with the Docker executor, if you use it with shell
# you will overwrite your user's SSH config.
- mkdir -p ~/.ssh
- '[[ -f /.dockerenv ]] && echo -e "Host *\n\tStrictHostKeyChecking no\n\n" > ~/.ssh/config'

variables:
  # Change this base on project name
  DEPLOYMENT_FOLDER_NAME: "tc-file"

test:
  image: voduytuan/gitlab-php-ci
  script:
  - bash ./ci/phplint.sh ./src/
  - phpcs --config-set ignore_errors_on_exit 1
  - phpcs --config-set ignore_warnings_on_exit 1
  - phpcs --standard=PSR2 --ignore=./src/index.php --error-severity=1 --warning-severity=8 -w --colors ./src/
  - phpunit --configuration ci/phpunit.xml

dev:
  image: voduytuan/gitlab-php-ci
  stage: deploy
  script:
  - ssh-add <(echo "$DEPLOYER_BETA_KEY")
  - echo "Deploy to $DEPLOYMENT_FOLDER_NAME"
  - rsync -avuz -e "ssh -p 22" --exclude-from="ci/deploy_exclude.txt" $CI_PROJECT_DIR/src/ $DEPLOYER_BETA_USER@$DEPLOYER_BETA_IP:/teamcrop/services/$DEPLOYMENT_FOLDER_NAME/src
  only:
  - dev

production:
  image: voduytuan/gitlab-php-ci
  stage: deploy
  script:
  - ssh-add <(echo "$DEPLOYER_PRODUCTION_KEY")
  - echo "Deploy to $DEPLOYMENT_FOLDER_NAME"
  - rsync -avuz -e "ssh -p 22" --exclude-from="ci/deploy_exclude.txt" $CI_PROJECT_DIR/src/ $DEPLOYER_PRODUCTION_USER@$DEPLOYER_PRODUCTION_IP:/teamcrop/services/$DEPLOYMENT_FOLDER_NAME/src
  only:
  - master
  when: manual

Trong ví dụ trên, phần test bên mình làm 3 việc:
– Chạy linter để đảm bảo sourcecode không bị lỗi cú pháp (https://www.pylint.org/, java: Apache Yetus)
– Kiểm tra source code có theo chuẩn PSR2 hay không.
– Chạy PHPUnit
- Rsync: Deploy with FTP, SFTP, SCP, RSYNC, SSH http://thecodestead.com/post/how-to-use-rsync-for-deployment/
	FTP: Làm việc tại local và khi đã sẵn sàng movw file to live server với FTP sofware như là Transmit: Vấn đề là which files did I change? Just moving everything ==> No version control

	Version Control Piece: GIT, SVN, Mercurial 
	==> Install Version Control	on Server, Pull From there (ssh + git pull)

	Cron Job: Run X every 2 minitues 
	Post-Receive Hooks/Webhooks: 
		github có một feature gọi là Post-Receive Hooks mà họ sẽ POST tới một URL do bạn chọn khi một repo được pushed. Có thể sử dụng POST request để chạy một script sẽ chạy command cần cho deployment cho ví dụ là git pull 


https://css-tricks.com/deployment/

	

	Ansible: SSH 


CI: Travis CI, Jenkins CI, CircleCI, COdeship 
https://www.thecodecampus.de/blog/jenkins-vs-gitlab-ci/


Về rsync: rsync: Là một file transfer program cho Unix system, rsync sử dụng rsync algorithm cung cấp fast method (chỉ chuyển thay đổi) cho việc remote file to sync. rsync là command nên sẽ thường chạy bởi task runner như Make hoặc rake


.  
https://about.gitlab.com/blog/2016/07/22/building-our-web-app-on-gitlab-ci/
So the first step of our migration was to insulate builds into Docker containers. In this way:

Every build is isolated from the others, and processes don’t crash each other randomly.
Building the same project on different architectures is easy, and that’s good news, because we need this to support multiple Debian versions.
Project maintainers have greater control on the setup of their build environment: no need to bother an admin when upgrading an SDK on the shared build machine



sudo docker run --detach \
  --hostname gitlab.ocs.com \
  --publish 443:443 --publish 5432:80 --publish 2222:22 \
  --name gitlab-api \
  --restart always \
  --volume /srv/gitlab/config:/etc/gitlab \
  --volume  /srv/gitlab/logs:/var/log/gitlab \
  --volume /srv/gitlab/data:/var/opt/gitlab \
  gitlab/gitlab-ce:9.0.3-ce.0


sudo docker run --detach \
  --hostname gitlab.ocs.com \
  --publish 443:443 --publish 5432:80 --publish 2222:22 \
  --name gitlab-api \
  --restart always \
  --volume /home/srv/gitlab/config:/etc/gitlab \
  --volume  /home/srv/gitlab/logs:/var/log/gitlab \
  --volume  /home/srv/gitlab/data:/var/opt/gitlab \
  gitlab/gitlab-ce:latest



ex


docker run -d --name gitlab-runner --restart always \
  -v /home/srv/gitlab-runner/config:/etc/gitlab-runner \
  -v /var/run/docker.sock:/var/run/docker.sock  -v /etc/hosts:/etc/hosts -v  /etc/ssl/certs/ca-bundle.crt:/etc/ssl/certs/ca-certificates.crt \
  gitlab/gitlab-runner:latest


#docker run --rm -t -i -v /srv/gitlab-runner/config:/etc/gitlab-runner gitlab/gitlab-runner register 
docker run --rm -t -i -v /home/srv/gitlab-runner/config:/etc/gitlab-runner   -v /etc/hosts:/etc/hosts  -v  /etc/ssl/certs/ca-bundle.crt:/etc/ssl/certs/ca-certificates.crt  gitlab/gitlab-runner register


vim /srv/gitlab-runner/config 
URL
token 
...

yum install xclip 
ssh-keygen -t  rsa -C "lamtv10@viettel.com.vn"

eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa 
xclip -set clip < ~/.ssh/id_rsa.pub 
ssh -v git@gitlab.ocs.com:2222 
git clone ssh://git@gitlab.ocs.com:2222/lamtv10/project3.git 
git clone ssh://git@gitlab_lc.com:2222/group1/project2.git

git config --global user.name "lamtv10"
git config --global user.email "lamtv10@viettel.com.vn"


git clone ssh://git@gitlab.ocs.com:2222/lamtv10/project1.git 
cd project3
touch README.md 
git add README.md 
git commit -m "add README"

git push -u origin master




git clone ssh://git@gitlab_lc.com:lamtv10/project3.git 


http://clusterfrak.com/sysops/app_installs/gitlab_container_registry/
https://www.starwindsoftware.com/blog/install-gitlab-https-and-the-container-registry

nginx['ssl_certificate'] = "/etc/gitlab/ssl/gitlab.crt"
nginx['ssl_certificate_key'] = "/etc/gitlab/ssl/gitlab.key"
nginx['ssl_ciphers'] = "ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES128-GCM-SHA256"
nginx['ssl_prefer_server_ciphers'] = "on"

##! **Recommended by: https://raymii.org/s/tutorials/Strong_SSL_Security_On_nginx.html
##!                   https://cipherli.st/**
nginx['ssl_protocols'] = "TLSv1.2 TLSv1.3"




There are no container images stored for this project
There are no container images stored for this project
With the Container Registry, every project can have its own space to store its Docker images. More Information

Quick Start
If you are not already logged in, you need to authenticate to the Container Registry by using your GitLab username and password. If you have Two-Factor Authentication enabled, use a Personal Access Token instead of a password.

docker login registry.ocs.com
You can add an image to this registry with the following commands:

docker build -t registry.ocs.com/lamtv10/project2 .
docker push registry.ocs.com/lamtv10/project2








file:///C:/Users/Administrator/Downloads/devopsismorethancicd-ver2-170714080919.pdf




file:///C:/Users/Administrator/Downloads/continuousdeliverywithansiblexgitlab-ci-170807054758.pdf


file:///C:/Users/Administrator/Downloads/nemytchenko-161029154729.pdf
grep "^[^#;]" smb.conf



***********docker login registry.ocs.com 
***********Error response from daemon: Get https://registry.ocs.com/v2: x509: certificate signed by unknow authority
*********** Sua bo xung /etc/docker/certs.d/gitlab.ocs.com 


Docker using link to talk
https://docs.docker.com/network/links/



usermod -aG docker gitlab-runner 
su - gitlab-runner 
git clone ssh://git@gitlab.ocs.com:2222/lamtv10/project3.git 


*******Sua loi gi fatal error bằng cách vào project/setting/general/clone 





curl -LJO https://gitlab-runner-downloads.s3.amazonaws.com/latest/rpm/gitlab-runner_amd64.rpm
gitlab-runner register





-
before_script
stages:
  - test
    + test1: make test 
    + test2: test 

  - build
    + compile
        artifacts:
          paths:
            - app 

  - release
    + image_build:
      images: docker:latest
      services:
        - docker:dind 

  - review
  - deploy





git clone ssh://git@172.16.29.193:2222/lamtv10/software_deployment.git 