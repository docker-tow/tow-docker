Tow Docker Image
================

Tow provides a docker image for working on distros like [CoreOS](https://coreos.com).

## Installation

Pull the image from the docker index. This is the recommended method of installation as it is easier to update image.

```
docker pull towproject/tow
```

Alternately you can build the image locally.

```
git clone https://github.com/docker-tow/tow-docker
cd tow-docker
docker build -t "$USER/tow" .
```

## Usage

Tow image requires mounting docker socket to work with docker installation from the container. Use `-v /var/run/docker.sock:/var/run/docker.sock` option when run it. 

By default `tow` image includes `docker-client 1.5.0`, if you need another version, specify it `-e DOCKER_VERSION=<version>`

#### Local projects

Mount project directory into `/workspace` volume and run required action:

```
$ docker run -v /var/run/docker.sock:/var/run/docker.sock \
-v $(pwd):/workspace towproject/tow <parameters>
```

#### Remote projects

Tow image also can work with remote projects in git repositories. Specify git repository with `-e GIT_REPO=<git_url>` and required branch with `-e GIT_BRANCH=<branch_name>` if needed, `master` by default. 

Remember to mount volume with ssh keys to `/root/.ssh` for private repositories. 

```
docker run -v /var/run/docker.sock:/var/run/docker.sock \
-e GIT_REPO="https://github.com/docker-tow/tow-nginx" \
towproject/tow build -t tow-nginx
```

```
docker run -v /var/run/docker.sock:/var/run/docker.sock \
-e GIT_REPO="https://github.com/docker-tow/tow-nginx" \
-e GIT_BRANCH="dev" \
towproject/tow build -t tow-nginx
```
