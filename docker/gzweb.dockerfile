FROM ubuntu:20.04

SHELL ["/bin/bash", "-c"]

RUN apt-get update
ENV DEBIAN_FRONTEND=noninteractive

# install basic dependencies
RUN apt-get install -y gazebo9 libgazebo9-dev curl git

# install build dependencies
RUN apt-get install -y  libjansson-dev libboost-dev imagemagick libtinyxml-dev mercurial cmake build-essential

# install web components
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
RUN source ~/.bashrc

ENV NVM_DIR="/root/.nvm"
RUN . $NVM_DIR/nvm.sh && nvm install 8

# begin build
RUN git clone https://github.com/osrf/gzweb gzweb
WORKDIR gzweb

RUN git checkout gzweb_1.4.1

RUN sh /usr/share/gazebo/setup.sh

RUN . $NVM_DIR/nvm.sh && npm run deploy --- -m

ENTRYPOINT . $NVM_DIR/nvm.sh && npm start
