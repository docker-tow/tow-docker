FROM gliderlabs/alpine
MAINTAINER Nikolay Yurin <yurinnick@outlook.com>

ENV DOCKER_VERSION="1.5.0" \
    TOW_BRANCH="dev" \
    GIT_BRANCH="master"

COPY run_tow.sh run_tow.sh
ADD "https://get.docker.com/builds/Linux/x86_64/docker-${DOCKER_VERSION}" /usr/local/bin/docker

RUN chmod +x /usr/local/bin/docker && \
    chmod +x run_tow.sh

RUN apk -q --update add python py-pip git && \
    rm -rf /var/cache/apk/*

RUN git clone -b ${TOW_BRANCH} https://github.com/docker-tow/tow /opt/tow && \
    pip install -q -e /opt/tow

RUN mkdir /root/.ssh && \
    touch /root/.ssh/known_hosts && \
    mkdir /workspace

VOLUME ["/root/.ssh", "/workspace"]
WORKDIR /workspace

ENTRYPOINT ["/run_tow.sh"]
