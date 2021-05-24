#!/bin/bash
session="Drone"
ROS_IP="192.168.1.70"
ROS_MASTER_URI="http://192.168.1.70:11311"
source_path="../devel/setup.bash"

tmux new-session -d -s $session
tmux rename-window 'Drone:|Mavros|VIZ->MAVROS|'
tmux split -h -p 50

tmux send-keys "export ROS_IP=$ROS_IP" C-m
tmux send-keys "export ROS_MASTER_URI=$ROS_MASTER_URI" C-m
tmux send-keys "source $source_path" C-m
tmux send-keys "sleep 0" C-m
tmux send-keys "roslaunch mavros apm.launch" C-m

tmux selectp -t 0
# tmux split -h -p 33
tmux send-keys "export ROS_IP=$ROS_IP" C-m
tmux send-keys "export ROS_MASTER_URI=$ROS_MASTER_URI" C-m
tmux send-keys "source $source_path" C-m
tmux send-keys "sleep 10" C-m
tmux send-keys "rosservice call /mavros/set_stream_rate 0 10 1" C-m


tmux new-window  -t Drone:1
tmux rename-window 'Drone:|RS_265|RS_265_UNDISTORT|ORB_SLAM|'


tmux selectp -t 0
tmux split -v -p 50
tmux send-keys "export ROS_IP=$ROS_IP" C-m
tmux send-keys "export ROS_MASTER_URI=$ROS_MASTER_URI" C-m
tmux send-keys "source $source_path" C-m
tmux send-keys "sleep 3" C-m
tmux send-keys "roslaunch realsense2_camera rs_t265.launch" C-m

tmux selectp -t 0
tmux split -h -p 33
tmux send-keys "export ROS_IP=$ROS_IP" C-m
tmux send-keys "export ROS_MASTER_URI=$ROS_MASTER_URI" C-m
tmux send-keys "source $source_path" C-m
tmux send-keys "sleep 5" C-m
tmux send-keys "roslaunch vision_to_mavros t265_tf_to_mavros.launch" C-m

tmux selectp -t 0
tmux split -h -p 33
tmux send-keys "export ROS_IP=$ROS_IP" C-m
tmux send-keys "export ROS_MASTER_URI=$ROS_MASTER_URI" C-m
tmux send-keys "source $source_path" C-m
tmux send-keys "sleep 6" C-m
tmux send-keys "roslaunch orb_slam2_ros orb_slam2_webcam.launch" C-m

tmux selectp -t 0
# tmux split -h -p 33
tmux send-keys "export ROS_IP=$ROS_IP" C-m
tmux send-keys "export ROS_MASTER_URI=$ROS_MASTER_URI" C-m
tmux send-keys "source $source_path" C-m
tmux send-keys "sleep 5" C-m
tmux send-keys "roslaunch vision_to_mavros t265_fisheye_undistort.launch" C-m