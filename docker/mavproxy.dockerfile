FROM ubuntu:22.04


ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

# RUN echo "Europe/Zurich" > /etc/timezone && \
RUN \
    apt-get update && \
    apt-get install -y \
        # python-dev \
        # python-opencv \
        # python-wxgtk3.0 \
        python3-pip \
        # python-matplotlib \
        # python-pygame \
        # python-lxml \
        # python-yaml \
    && \
    apt-get clean all
RUN pip3 install --upgrade pip
RUN pip3 install --upgrade setuptools && \
    pip3 install --upgrade MAVProxy
RUN apt install net-tools

ENTRYPOINT mavproxy.py --master 'tcp:127.0.0.1:5760'