FROM ubuntu:20.04

SHELL ["/bin/bash", "-c"]
ENV DEBIAN_FRONTEND=noninteractive
ENV ROS_DISTRO=foxy

RUN apt-get update && apt-get upgrade -y
# Editors and so on
RUN apt-get install -y vim git tmux bash-completion sudo locales curl gnupg2 lsb-release python3-argcomplete
RUN locale-gen ja_JP ja_JP.UTF-8
RUN update-locale LC_ALL=ja_JP.UTF-8 LANG=ja_JP.UTF-8
ENV LANG=ja_JP.UTF-8
RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add -
RUN sh -c 'echo "deb [arch=amd64,arm64] http://packages.ros.org/ros2/ubuntu `lsb_release -cs` main" > /etc/apt/sources.list.d/ros2-latest.list'
RUN apt-get update
RUN apt-get install -y ros-${ROS_DISTRO}-desktop python3-colcon-common-extensions python3-rosdep python3-vcstool
