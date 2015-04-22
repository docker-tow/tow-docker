FROM debian:jessie
MAINTAINER Nikolay Yurin <yurinnick@outlook.com>

ENV DOCKER_VERSION 1.5.0
ENV GIT_BRANCH master

RUN apt-get update && \
    apt-get install --no-install-recommends -y python python-pip curl git && \
    apt-get clean -y

RUN curl -sfL "https://get.docker.com/builds/Linux/x86_64/docker-${DOCKER_VERSION}" \
    -o /usr/local/bin/docker && \
    chmod +x /usr/local/bin/docker

COPY run_tow.sh run_tow.sh

RUN pip install -q --pre -I tow && \
    chmod +x run_tow.sh

RUN mkdir /root/.ssh && \
    touch /root/.ssh/known_hosts && \
    mkdir /workspace

VOLUME ["/root/.ssh", "/workspace"]
WORKDIR /workspace

ENTRYPOINT ["/run_tow.sh"]
