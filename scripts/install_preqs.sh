#!/bin/bash
apt-get install geographiclib-tools
apt-get install libgeographic-dev

git_tree_root=$(git rev-parse --show-toplevel)
gazebo_models_path="${git_tree_root}/models/gazebo"
mkdir -p ${gazebo_models_path}

# moving models to new directory
mv ${git_tree_root}/src/modules/aws-robomaker-small-house-world/models/* ${gazebo_models_path}
cp -r ${git_tree_root}/src/modules/iq_sim/models/* ${gazebo_models_path}