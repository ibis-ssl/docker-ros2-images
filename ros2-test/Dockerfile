FROM nvidia/opengl:1.0-glvnd-runtime-ubuntu18.04

SHELL ["/bin/bash", "-c"]
ENV DEBIAN_FRONTEND=noninteractive
ENV ROS_DISTRO=dashing

RUN apt-get update && apt-get upgrade -y
# Editors and so on
RUN apt-get install -y vim git tmux bash-completion sudo locales curl gnupg2 lsb-release python3-argcomplete
RUN locale-gen ja_JP ja_JP.UTF-8
RUN update-locale LC_ALL=ja_JP.UTF-8 LANG=ja_JP.UTF-8
ENV LANG=ja_JP.UTF-8
RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add -
RUN sh -c 'echo "deb [arch=amd64,arm64] http://packages.ros.org/ros2/ubuntu `lsb_release -cs` main" > /etc/apt/sources.list.d/ros2-latest.list'
RUN apt-get update
RUN apt-get install -y ros-${ROS_DISTRO}-desktop python3-colcon-common-extensions
# RUN apt-get install -y ros-${ROS_DISTRO}-rmw-opensplice-cpp ros-${ROS_DISTRO}-rmw-connect-cpp
# RUN apt-get install -y ros-${ROS_DISTRO}-ros1-bridge
RUN mkdir -p $HOME/ros2_example_ws/src && \
        cd $HOME/ros2_example_ws && \
        git clone https://github.com/ros2/examples src/examples && \
        cd src/examples && \
        git checkout ${ROS_DISTRO} && \
        cd $HOME/ros2_example_ws && \
        source /opt/ros/${ROS_DISTRO}/setup.bash && \
        colcon build --symlink-install && \
        colcon test
