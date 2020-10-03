build.sh
1001  vim /etc/docker/daemon.json
 1002  mkdir /home/docker_data/var/lib/
 1003  mkdir -p /home/docker_data/var/lib/
 1004  systemctl stop docker
 1005  cp -a /var/lib/docker /home/docker_data/var/lib/
 1006  systemctl start docker
 1007  du -f /home/docker_data/
 1008  du -h /home/docker_data/
 1009  df -h
 1010  history




/********************************************

maven 


172.16.29.193
which mvn 
/home/thuanlk/nfvi/maven/bin/mvn 
cd /home/thuanlk/nfvi/maven
vim conf/settings.xml

<mirror>
      <id>internal</id>
      <url>http://172.16.29.193:8888/repository/internal/</url>
      <mirrorOf>external:*</mirrorOf>
    </mirror>
    <mirror>
      <id>snapshots</id>
      <mirrorOf>snapshots</mirrorOf>
      <url>http://172.16.29.193:8888/repository/snapshots/</url>
    </mirror>

  </mirrors>




193 vs http://172.16.31.116:8888/#upload


#######################$$$$$$$$$$$$$$$$$$$$$$$



vim /etc/profile


MVN_HOME=/home/thuanlk/nfvi/maven
PATH=$MVN_HOME/bin:$PATH

alias controller01='ssh -XC root@172.16.29.193'
alias controller02='ssh -XC root@172.16.29.194'
alias controller03='ssh -XC root@172.16.29.195'
alias compute01='ssh -XC root@172.16.29.196'
alias compute02='ssh -XC root@172.16.29.197'
alias compute03='ssh -XC root@172.16.29.198'
alias compute04='ssh -XC root@172.16.29.194'
alias compute05='ssh -XC root@172.16.29.189'

alias master='ssh -XC root@172.16.29.234'
alias worker01='ssh -XC root@172.16.29.195'
alias worker02='ssh -XC root@172.16.29.198'


cp -r -n /home/lamtv10/repository/* /home/thuanlk/nfvi/apache-archiva-2.2.4/repositories/internal/

java -cp "./lib/*.jar:auto_nfvi.jar" automation.Automation


*****************************************/


usermod -aG wheel gitlab-runner
sudo visudo /* bo phan  %wheel  ALL=(ALL)       NOPASSWD: ALL


////////////////


Anh gui chu lệnh chạy Akka  HTTP
bin/java -cp "./lib/*.jar:AkkaServer.jar" -Dport=9000 -DmsgSize=2000 serverakka.HighLevelAkka
bin/java -cp "./lib/*.jar:AkkaServer.jar"      -Dhost=172.16.30.64 -Dtps=10000 -Dport=9000 -DnumberThread=5 -DpoolSize=10 -DmsgSize=2000 akkaClient.SendHttpHighLevel

lenh chay http2:
bin/java   -Xbootclasspath/p:alpn-boot-8.1.12.v20180117.jar -cp "./lib/*.jar:jetty940.jar"    test.Http2Server  

bin/java   -Xbootclasspath/p:alpn-boot-8.1.12.v20180117.jar -cp "./lib/*.jar:jetty940.jar"       -DnumberThread=1 -DmsgSize=2000   -DpoolSize=1   test.SendLowLevelClient  


../jdk/bin/jar cf lamtv10.jar ./src/*


../jdk/bin/java -cp "./lib/*.jar:lamtv10.jar" main.java.automation.Automation


../jdk/bin/jar -cvfm example.jar src/main/resources/META-INF/MANIFEST.MF  src/main/java/*.class


../jdk/bin/javac -cp "./lib/*.jar"   -sourcepath src    src/main/java/automation/common/*.java    src/main/java/automation/entity/*.java   src/main/java/automation/lamtv10/*.java   src/main/java/automation/service/*.java src/main/java/automation/Automation.java 