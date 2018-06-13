# build: docker build -t generalmeow/jenkins-tools:<TAG> .
# notes: This image is used for the jenkins pipeline. it contains the tools required to run
# pipeline builds etc
FROM ubuntu:18.04
MAINTAINER Paul Hoang 2018-06-05
RUN ["apt", "update"]
RUN ["apt", "upgrade", "-y"]
RUN ["apt", "install", "gradle", "git", "maven", "-y"]
WORKDIR /root

ADD ["./files/jdk-8u171-linux-arm32-vfp-hflt.tar.gz", "/root"]
ENV JAVA_HOME=/root/jdk1.8.0_171
ENV CLASSPATH=.
ENV PATH=${JAVA_HOME}/bin:${PATH}

# MAVEN
RUN ["mkdir", ".m2"]
ADD ["./files/m2/settings.xml", "./.m2"]
ADD ["./files/m2/settings-security.xml", "./.m2"]