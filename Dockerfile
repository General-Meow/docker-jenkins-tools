# build: docker build -t generalmeow/jenkins-tools:<TAG> .
# notes: This image is used for the jenkins pipeline. it contains the tools required to run
# pipeline builds etc
FROM ubuntu:18.04
MAINTAINER Paul Hoang 2018-06-17
RUN ["apt", "update"]
RUN ["apt", "upgrade", "-y"]
RUN ["apt", "install", "gradle", "git", "maven", "docker.io", "curl", "gnupg", "-y"]

#add k8
RUN ["curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -"
RUN ["echo 'deb http://apt.kubernetes.io/ kubernetes-xenial main' | tee /etc/apt/sources.list.d/kubernetes.list"]
RUN ["apt", "update"]
RUN ["apt", "install", "kubeadm"]

WORKDIR /root

ADD ["./files/jdk-8u171-linux-arm32-vfp-hflt.tar.gz", "/root"]
ENV JAVA_HOME=/root/jdk1.8.0_171
ENV CLASSPATH=.
ENV PATH=${JAVA_HOME}/bin:${PATH}

# MAVEN
RUN ["mkdir", ".m2"]
ADD ["./files/m2/settings.xml", "./.m2"]
ADD ["./files/m2/settings-security.xml", "./.m2"]

# Maven cache - mounted so that maven runs between steps do not need to download dependcies again
RUN ["mkdir", "./.m2/repository"]
VOLUME ["/root/.m2/repository"]