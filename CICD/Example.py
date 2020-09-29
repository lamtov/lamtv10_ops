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



docker run --detach \
    --hostname gitlab.ocs.com \
    --publish 5432:80 --publish 2222:22 \
    --name gitlab9 \
    --restart=always \
    --volume /gitlab9/config:/etc/gitlab \
    --volume /gitlab9/logs:/var/log/gitlab \
    --volume /gitlab9/data:/var/opt/gitlab \
    gitlab/gitlab-ce:latest




docker run -d --name gitlab-runner --restart always \
  -v /srv/gitlab-runner/config:/etc/gitlab-runner \
  -v /var/run/docker.sock:/var/run/docker.sock \
  gitlab/gitlab-runner:latest


docker run --rm -t -i -v /srv/gitlab-runner/config:/etc/gitlab-runner gitlab/gitlab-runner register 



vim /srv/gitlab-runner/config 
URL
token 
...

yum install xclip 
ssh-keygen -t  rsa -C "lamtv10@viettel.com.vn"

eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa 
xclip -set clip < ~/.ssh/id_rsa.pub 
ssh -v git@gitlag.ocs.com 
git clone ssh://git@gitlag.ocs.com:2222/lamtv10/project3.git 

git clone ssh://git@gitlab.ocs.com:2222/gr1/project1.git

git config --global user.name "lamtv10"
git config --global user.email "lamtv10@viettel.com.vn"



git clone git@gitlab_lc.com:lamtv10/project3.git 
cd project3
touch README.md 
git add README.md 
git commit -m "add README"

git push -u origin master





////////// config.toml
concurrent=1
check_interval=0
[session_server]




sudo docker run --detach \
  --hostname gitlab.ocs.com \
  --publish 5432:80 --publish 2222:22 \
  --name gitlab \
  --env GITLAB_OMNIBUS_CONFIG="external_url 'http://gitlab.ocs.com/';" \
  --restart always \
  --volume /srv/gitlab/config:/etc/gitlab \
  --volume /srv/gitlab/logs:/var/log/gitlab \
  --volume /srv/gitlab/data:/var/opt/gitlab \
  gitlab/gitlab-ce:latest




git config --global user.name "mailp"
git config --global user.email "mailp@vttek.vn"

git clone ssh://git@gitlab.ocs.com:2222/lamtv10/software_deployment.git 
cd software_deployment
git status
git checkout -b test/mailp
vim README.md ("THIS IS TEST BRANCH")
git status 

touch newFIle 
git status 

git add .
git commit -m "mailp test "
git config --global push.default matching
git push -u origin test/mailp 


touch newFIle2 

git push

git checkout master 
ls (kiểm tra thư mục )

git checkout test/mailp 
ls (kiểm tra thư mục)



sffsdfs 

git push -u orign test/mailp 

lan sau git push









******************** gitlab-runner docker permision ****************
usermod -aG docker gitlab-runner
sudo service docker restart



