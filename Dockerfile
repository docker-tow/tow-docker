FROM debian:jessie
MAINTAINER Nikolay Yurin <yurinnick@outlook.com>

ENV GIT_BRANCH master

RUN apt-get update && \
    apt-get install -y python python-pip curl git && \
    curl -sSL https://get.docker.com | sh && \
    apt-get clean -y

COPY run_tow.sh run_tow.sh

RUN pip install -q --pre -I tow && \
    chmod +x run_tow.sh

RUN mkdir /root/.ssh && \
    touch /root/.ssh/known_hosts && \
    mkdir /workspace

VOLUME ["/root/.ssh", "/workspace"]
WORKDIR /workspace

ENTRYPOINT ["/run_tow.sh"]
