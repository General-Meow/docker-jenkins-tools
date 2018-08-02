# build: docker build -t generalmeow/jenkins-tools:<TAG> .
# notes: This image is used for the jenkins pipeline. it contains the tools required to run
# pipeline builds etc
FROM ubuntu:18.04
MAINTAINER Paul Hoang 2018-08-02

#add k8

RUN ["apt", "update"]
RUN ["apt", "install", "curl", "gnupg", "-y"]
RUN sh -c 'curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -'
RUN sh -c 'echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list'

RUN ["apt", "update"]
RUN ["apt", "upgrade", "-y"]
RUN ["apt", "install", "gradle", "git", "maven", "docker.io", "kubeadm", "-y"]

WORKDIR /root

ADD ["./files/jdk-8u181-linux-arm32-vfp-hflt.tar.gz", "/root"]
ENV JAVA_HOME=/root/jdk1.8.0_181
ENV CLASSPATH=.
ENV PATH=${JAVA_HOME}/bin:${PATH}

# MAVEN
RUN ["mkdir", ".m2"]
ADD ["./files/m2/settings.xml", "./.m2"]
ADD ["./files/m2/settings-security.xml", "./.m2"]

# Maven cache - mounted so that maven runs between steps do not need to download dependencies again
RUN ["mkdir", "./.m2/repository"]
VOLUME ["/root/.m2/repository"]
