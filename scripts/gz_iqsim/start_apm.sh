#!/bin/bash

ROS_IP="localhost"
source_path="/home/devel/setup.bash"

source $source_path && sleep 3 && roslaunch iq_sim apm.launch
