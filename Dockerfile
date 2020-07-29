FROM debian:stretch
LABEL maintainer="David Baumgold <david@davidbaumgold.com>"

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Installs the `dpkg-buildpackage` command
RUN apt-get update
RUN apt-get install build-essential debhelper devscripts perl python3 python3-virtualenv -y

# Install `dh-virtualenv` 1.2
RUN deb http://http.us.debian.org/debian bullseye main
RUN apt-get download dh-virtualenv
RUN dpkg -i -f --ignore-depends=perl,python3,virtualenv,sphinx-rtd-theme-common dh-virtualenv.deb

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
