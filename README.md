# UAVIsion
#### The open platform for visual odometry for Unmanned Aerial Vehicles
---
## Introduction
This platform designed to be ROS compatible therefore it based on ROS and inherit all ROS's approaches.

---
## Process
To use this platform the several steps need to be taken.
1. Install Prerequisites
2. Build the platform
3. Add your module
4. Test module in simulator
5. Test module in UAV

## Prerequisites
1. Install ROS Noetic (Kenetic version not tested, but should work too)
2. Install latest OpenCV
3. (Optional) Install realsense libs if you planning to use with this type of camera (realsense t265)
4. ADDITIONAL MODULES
   1. ros-noetic-geographic-msgs
   2. ros-noetic-mavlink
   3. ros-noetic-ddynamic-reconfigure
   4. ros-noetic-mavros

## Build
1. Clone project recursively with command 
    ```bash 
    git clone --recursive https://github.com/janchk/UAVision
    ```
2. Source your ROS installation if you haven't done it already 
3. Navigate to source directory
4. Build project with following command
    ```bash 
    catkin build 
    ```

## Module addition
* Your module need to be placed in `src/modules` section. 
* The module need to preserve classic  structure of catkin package and must be able to execute with `rosrun` or `roslaunch` commands.

## Module testing
To test pipeline with your module you need to make following actions
1. Build whole project with 
   ```bash 
   catkin build 
   ```
2. Resource project with 
   ```bash 
   source devel/setup.bash
   ```
3. Launch all modules of pipeline. Examples may be found in `scripts/init_sim_ws.sh` script for simulation purposes and in `scripts/init_drone_ws.sh` for UAV experience.
