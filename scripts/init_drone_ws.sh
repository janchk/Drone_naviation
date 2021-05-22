#!/bin/bash
session="Drone"
ROS_IP="192.168.1.70"
ROS_MASTER_URI="http://192.168.1.70:11311"
source_path="../devel/setup.bash"
# source ../devel/setup.bash

# tmux new-session -s $session
tmux new-session -d -s $session
tmux rename-window 'Drone:|Mavros|VIZ->MAVROS|'
tmux split -p 33

tmux send-keys "export ROS_IP=$ROS_IP" C-m
tmux send-keys "export ROS_MASTER_URI=$ROS_MASTER_URI" C-m
tmux send-keys "source $source_path" C-m
tmux send-keys "roslaunch mavros apm.launch" C-m

tmux selectp -t 0
# tmux splitw -h -p 33
tmux send-keys "export ROS_IP=$ROS_IP" C-m
tmux send-keys "export ROS_MASTER_URI=$ROS_MASTER_URI" C-m
tmux send-keys "source $source_path" C-m
tmux send-keys "roslaunch vision_to_mavros t265_tf_to_mavros.launch" C-m


tmux new-window  -t Drone:1
tmux rename-window 'Drone:|RS_265|RS_265_UNDISTORT|ORB_SLAM|'

tmux selectp -t 0
tmux splitw -w -p 50
tmux send-keys "export ROS_IP=$ROS_IP" C-m
tmux send-keys "export ROS_MASTER_URI=$ROS_MASTER_URI" C-m
tmux send-keys "source $source_path" C-m
tmux send-keys "roslaunch orb_slam_2 orb_slam2_webcam.launch" C-m

tmux selectp -t 0
tmux splitw -h -p 33
tmux send-keys "export ROS_IP=$ROS_IP" C-m
tmux send-keys "export ROS_MASTER_URI=$ROS_MASTER_URI" C-m
tmux send-keys "source $source_path" C-m
tmux send-keys "roslaunch realsense2_camera rs_t265.launch" C-m

tmux selectp -t 0
tmux splitw -h -p 33
tmux send-keys "export ROS_IP=$ROS_IP" C-m
tmux send-keys "export ROS_MASTER_URI=$ROS_MASTER_URI" C-m
tmux send-keys "source $source_path" C-m
tmux send-keys "roslaunch vision_to_mavros t265_fisheye_undistort.launch" C-m



# tmux split-window -h -t dev:0
# tmux split-window -v -t dev:0.1