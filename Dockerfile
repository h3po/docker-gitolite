FROM debian:stable-slim

ENV DEBIAN_FRONTEND=noninteractive
ARG GITOLITE_REPO=https://github.com/sitaramc/gitolite.git
ARG GITOLITE_VERSION=master

RUN apt-get update && \
    apt-get -y install openssh-server git && \
    apt-get clean && \
    useradd -r -u 196 -d /var/lib/gitolite -m gitolite && \
    mkdir /usr/local/gitolite && \
    git clone --depth 1 -b $GITOLITE_VERSION $GITOLITE_REPO /tmp/gitolite && \
    /tmp/gitolite/install -to /usr/local/gitolite && \
    ln -s /usr/local/gitolite/gitolite /usr/local/bin/gitolite && \
    rm -rf /tmp/gitolite

EXPOSE 2222
VOLUME /var/lib/gitolite
WORKDIR /var/lib/gitolite
COPY start.sh /usr/local/bin
USER gitolite

CMD start.sh
