FROM debian:stretch
LABEL maintainer="David Baumgold <david@davidbaumgold.com>"

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Installs the `dpkg-buildpackage` command
RUN apt-get update
RUN apt-get install -y build-essential debhelper devscripts

# Install `dh-virtualenv` 1.2
RUN curl --output /tmp/dh-virtualenv.deb https://download.nylas.com/gha-deps/dh-virtualenv_1.2.1-1~stretch_all.deb
RUN apt-get install -y /tmp/dh-virtualenv.deb

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
