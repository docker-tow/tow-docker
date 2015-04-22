#!/bin/sh

version=$(docker version | grep "Client version" | cut -d' ' -f 3)

if [ $version != ${DOCKER_VERSION} ]; then
  curl -sfL "https://get.docker.com/builds/Linux/x86_64/docker-${DOCKER_VERSION}" -o /usr/local/bin/docker
  chmod +x /usr/local/bin/docker
fi

if [ ! -z ${GIT_REPO} ]; then
  git clone -q -b ${GIT_BRANCH} ${GIT_REPO}
  cd $(basename ${GIT_REPO})
fi

tow "$@"