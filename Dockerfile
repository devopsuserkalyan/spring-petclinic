FROM centos
MAINTAINER kalyan
RUN yum -y upgrade && yum install wget -y 
WORKDIR /opt
RUN yum install git -y
RUN yum install --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/$JAVA_VERSION-$BUILD_VERSION/jdk-$JAVA_VERSION-linux-x64.rpm" -O /tmp/jdk-8-linux-x64.rpm
RUN yum -y install /tmp/jdk-8-linux-x64.rpm
ENV JAVA_HOME=/opt/jdk-8-linux-x64
ENV JAVA_PATH=$PATH:/opt/jdk-8-1inux-x64/bin

WORKDIR /opt/tomcat
RUN wget http://apache.mirrors.ionfish.org/tomcat/tomcat-8/v8.5.9/bin/apache-tomcat-8.5.9.tar.gz && tar -xvzf apache-tomcat-8*tar.gz && mv apache-tomcat-8 tomcat-8
WORKDIR /tomcat-8/conf/
RUN echo '<role rolename="manager-gui"/>' >> tomcat-user.xml
RUN echo '<role rolename="manager-script"/>' >> tomcat-user.xml
RUN echo '<user username="tomcat" password="tomcat" roles="manager-gui,manager-script"/>'


COPY /var/lib/jenkins/workspace/project/target/petclinic.war /opt/tomcat/webapps
