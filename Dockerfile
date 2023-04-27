FROM debian:stretch
LABEL maintainer="David Baumgold <david@davidbaumgold.com>"

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Stretch has been moved to archive.debian.org: https://lists.debian.org/debian-devel-announce/2023/03/msg00006.html
RUN echo "deb http://archive.debian.org/debian-archive/debian/ stretch main" > /etc/apt/sources.list
RUN echo "deb http://archive.debian.org/debian-security/ stretch/updates main" >> /etc/apt/sources.list
RUN apt-get update

# Install the `dpkg-buildpackage` command
RUN apt-get install --yes build-essential debhelper devscripts

# Install `dh-virtualenv` 1.2
RUN curl -o /tmp/dh-virtualenv.deb https://download.nylas.com/gha-deps/dh-virtualenv_1.2.1-1~stretch_all.deb
RUN apt-get install --yes /tmp/dh-virtualenv.deb

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
