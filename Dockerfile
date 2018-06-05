# build: docker build -t generalmeow/jenkins-tools:<TAG> .
# notes: This image is used for the jenkins pipeline. it contains the tools required to run
# pipeline builds etc
FROM ubuntu:18.04
MAINTAINER Paul Hoang 2018-06-05
RUN ["apt", "update"]
RUN ["apt", "upgrade", "-y"]
RUN ["apt", "install", "gradle", "git", "maven", "-y"]
WORKDIR /home

ADD ["./files/jdk-8u171-linux-arm32-vfp-hflt.tar.gz", "/home"]
ENV JAVA_HOME=/home/jdk1.8.0_171
ENV CLASSPATH=.
ENV PATH=${JAVA_HOME}/bin:${PATH}
