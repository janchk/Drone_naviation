#!/bin/bash
session="Drone"
ROS_IP="localhost"
# ROS_MASTER_URI="http://192.168.1.70:11311"
source_path="../devel/setup.bash"
git_tree_root=$(git rev-parse --show-toplevel)
gazebo_models_path="${git_tree_root}/models/gazebo"
ardupilot_path="/home/jakhremchik/Documents/drone/other/ardupilot"

tmux new-session -d -s $session
tmux rename-window 'Drone:|Mavros|VIZ->MAVROS|'
tmux split -h -p 50

# tmux send-keys "export ROS_IP=$ROS_IP" C-m
# tmux send-keys "export ROS_MASTER_URI=$ROS_MASTER_URI" C-m
tmux send-keys "source $source_path" C-m
tmux send-keys "sleep 6" C-m
tmux send-keys "roslaunch iq_sim apm.launch" C-m

tmux selectp -t 0
# tmux split -h -p 33
# tmux send-keys "export ROS_IP=$ROS_IP" C-m
# tmux send-keys "export ROS_MASTER_URI=$ROS_MASTER_URI" C-m
tmux send-keys "export GAZEBO_MODEL_PATH=$GAZEBO_MODEL_PATH:$gazebo_models_path" C-m
tmux send-keys "source $source_path" C-m
tmux send-keys "sleep 4" C-m
tmux send-keys "roslaunch iq_sim smallhouse.launch" C-m

# tmux selectp -t 0
# tmux split -h -p 33
# tmux send-keys "sleep 6" C-m
# # tmux send-keys "export ROS_IP=$ROS_IP" C-m
# # tmux send-keys "export ROS_MASTER_URI=$ROS_MASTER_URI" C-m
# tmux send-keys "$ardupilot_path/Tools/autotest/sim_vehicle.py -v ArduCopter -f gazebo-iris --console" C-m



tmux new-window  -t Drone:1
tmux rename-window 'Drone:|RS_265|RS_265_UNDISTORT|ORB_SLAM|'


tmux selectp -t 0
tmux split -v -p 50

tmux send-keys "source $source_path" C-m
tmux send-keys "sleep 5" C-m
tmux send-keys "rviz rviz -d ../config/rviz_conf.rviz" C-m

tmux selectp -t 0
tmux split -h -p 33
tmux send-keys "export ROS_IP=$ROS_IP" C-m
tmux send-keys "export ROS_MASTER_URI=$ROS_MASTER_URI" C-m
tmux send-keys "source $source_path" C-m
tmux send-keys "sleep 6" C-m
tmux send-keys "roslaunch orb_slam2_ros orb_slam2_t265_mono.launch" C-m

tmux selectp -t 0
# tmux split -h -p 33
tmux send-keys "export ROS_IP=$ROS_IP" C-m
tmux send-keys "export ROS_MASTER_URI=$ROS_MASTER_URI" C-m
tmux send-keys "source $source_path" C-m
tmux send-keys "sleep 5" C-m
tmux send-keys "roslaunch vision_to_mavros t265_fisheye_undistort.launch" C-m

tmux attac -t Drone