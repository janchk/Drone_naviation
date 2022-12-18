FROM ubuntu:focal

# setup timezone
RUN echo 'Etc/UTC' > /etc/timezone && \
    ln -s /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
    apt-get update && \
    apt-get install -q -y --no-install-recommends tzdata && \
    rm -rf /var/lib/apt/lists/*

# install packages
RUN apt-get update && apt-get install -q -y --no-install-recommends \
    dirmngr \
    gnupg2 \
    lsb-release \
    curl \
    && rm -rf /var/lib/apt/lists/*
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

# setup keys
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys D2486D2DD83DB69272AFE98867170598AF249743
RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc >> /tmp/ros.asc 
RUN apt-key add /tmp/ros.asc
# setup sources.list
RUN . /etc/os-release \
    && echo "deb http://packages.osrfoundation.org/gazebo/$ID-stable `lsb_release -sc` main" > /etc/apt/sources.list.d/gazebo-latest.list

# install gazebo packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    gazebo11=11.12.0-1* \
    && rm -rf /var/lib/apt/lists/*

# install ros-gazebo packages
RUN apt-get install ros-noetic-gazebo-ros-pkgs ros-noetic-gazebo-ros-control

# setup environment
EXPOSE 11345
RUN mkdir gzserver
WORKDIR gzserver
ADD models models
ENV GAZEBO_MODEL_PATH=$GAZEBO_MODEL_PATH:"/gzserver/models/gazebo"


# setup entrypoint
COPY ./docker/gzserver_entrypoint.sh /

ENTRYPOINT ["/gzserver_entrypoint.sh"]
CMD ["gzserver"]