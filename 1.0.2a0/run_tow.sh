#!/bin/sh

if [ ! -z ${GIT_REPO} ]; then
  git clone -q -b ${GIT_BRANCH} ${GIT_REPO}
  cd $(basename ${GIT_REPO})
fi

tow "$@"