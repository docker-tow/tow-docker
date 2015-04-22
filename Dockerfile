FROM debian:jessie
MAINTAINER Nikolay Yurin <yurinnick@outlook.com>

ENV GIT_BRANCH master

RUN apt-get update && \
    apt-get install -y python python-pip curl git && \
    apt-get clean -y

ADD https://get.docker.com/builds/Linux/x86_64/docker-1.5.0 /usr/local/bin/docker
RUN chmod +x /usr/local/bin/docker

COPY run_tow.sh run_tow.sh

RUN pip install -q --pre -I "tow>=1.0.2a0,<1.0.0" && \
    chmod +x run_tow.sh

RUN mkdir /root/.ssh && \
    touch /root/.ssh/known_hosts && \
    mkdir /workspace

VOLUME ["/root/.ssh", "/workspace"]
WORKDIR /workspace

ENTRYPOINT ["/run_tow.sh"]
