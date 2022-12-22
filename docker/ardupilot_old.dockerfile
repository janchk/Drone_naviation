FROM ubuntu:18.04

# ARG COPTER_TAG=Copter-4.0.4
ARG COPTER_TAG=master

# install git 
RUN apt-get update && apt-get install -y git

# install debug stuff
# RUN apt-get install tmux nano net-tools 

RUN git config --global url."https://github".insteadOf git://github

# Now grab ArduPilot from GitHub
# RUN git clone https://github.com/ArduPilot/ardupilot.git ardupilot --recursive
RUN git clone https://github.com/ArduPilot/ardupilot.git ardupilot
WORKDIR ardupilot

# Checkout the latest Copter...
RUN git checkout ${COPTER_TAG}

# Now start build instructions from http://ardupilot.org/dev/docs/setting-up-sitl-on-linux.html
RUN git submodule update --init --recursive

# Trick to get apt-get to not prompt for timezone in tzdata
ENV DEBIAN_FRONTEND=noninteractive

# Need sudo and lsb-release for the installation prerequisites
RUN apt-get install -y sudo lsb-release tzdata python3 python3-pip

# Need USER set so usermod does not fail...
# Install all prerequisites now
# RUN groupadd -r user && useradd -r -g user user
USER 1000:1000
RUN USER=1000 Tools/environment_install/install-prereqs-ubuntu.sh -y
USER root
# RUN pip2 uninstall mavproxy -y

RUN pip3 install mavproxy

# Continue build instructions from https://github.com/ArduPilot/ardupilot/blob/master/BUILD.md
RUN ./waf distclean
RUN ./waf configure --board sitl
RUN ./waf copter
RUN ./waf rover 
RUN ./waf plane
RUN ./waf sub

# TCP 5760 is what the sim exposes by default
EXPOSE 5760/tcp

# Variables for simulator
ENV INSTANCE 0
ENV LAT 42.3898
ENV LON -71.1476
ENV ALT 14
ENV DIR 270
ENV MODEL +
ENV SPEEDUP 1
ENV VEHICLE ArduCopter

# Finally the command

# RUN echo "/ardupilot/Tools/autotest/sim_vehicle.py --no-mavproxy -v ArduCopter -f gazebo-iris --console" >> /entrypoint.sh 
# RUN echo "/ardupilot/Tools/autotest/sim_vehicle.py -v ArduCopter --out=udp:10.0.0.2:14551 --console" >> /entrypoint.sh 
RUN echo "/ardupilot/Tools/autotest/sim_vehicle.py -v ArduCopter --out=udp:127.0.0.1:14551 --console" >> /entrypoint.sh 
# ENTRYPOINT bash 
ENTRYPOINT bash /entrypoint.sh

# ENTRYPOINT /ardupilot/Tools/autotest/sim_vehicle.py --vehicle ${VEHICLE} -I${INSTANCE} --custom-location=${LAT},${LON},${ALT},${DIR} -w -f gazebo-iris --no-rebuild --console --speedup ${SPEEDUP}
