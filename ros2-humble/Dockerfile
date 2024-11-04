ARG ROS_DISTRO="humble"
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Add vscode user with same UID and GID as your host system
# (copied from https://code.visualstudio.com/remote/advancedcontainers/add-nonroot-user#_creating-a-nonroot-user)
ARG USERNAME=developer
ARG USER_UID=1000
ARG USER_GID=$USER_UID
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME
# Switch from root to user
USER $USERNAME
SHELL ["/bin/bash", "-c"]

RUN sudo apt-get update && \
    DEBIAN_FRONTEND=noninteractive TZ=Asia/Tokyo sudo apt-get install -y tzdata && \
    sudo ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && \
    sudo dpkg-reconfigure --frontend noninteractive tzdata && \
    sudo apt-get clean && \
    sudo rm -rf /var/lib/apt/lists/*

# install packages
RUN sudo apt-get update && sudo apt-get install -q -y --no-install-recommends \
    dirmngr \
    gnupg2 \
    lsb-release \
    locales \
    wget \
    curl \
    bash-completion \
    build-essential \
    ca-certificates \
    git \
    && sudo rm -rf /var/lib/apt/lists/*

RUN sudo locale-gen ja_JP ja_JP.UTF-8
RUN sudo update-locale LC_ALL=ja_JP.UTF-8 LANG=ja_JP.UTF-8
ENV LANG=ja_JP.UTF-8

ENV ROS_DISTRO=humble

RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.key | sudo apt-key add -

RUN sudo sh -c 'echo "deb [arch=$(dpkg --print-architecture)] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros2-latest.list'

# install ros2 packages
RUN sudo apt-get update && sudo apt-get install -y --no-install-recommends \
    ros-humble-desktop \
    && sudo rm -rf /var/lib/apt/lists/*

# install bootstrap tools
RUN sudo apt-get update && sudo apt-get install --no-install-recommends -y \
    python3-colcon-common-extensions \
    python3-colcon-mixin \
    python3-rosdep \
    python3-vcstool \
    && sudo rm -rf /var/lib/apt/lists/*

# bootstrap rosdep
RUN sudo rosdep init && \
  rosdep update --rosdistro $ROS_DISTRO

# setup colcon mixin and metadata
# RUN colcon mixin add default \
#       https://raw.githubusercontent.com/colcon/colcon-mixin-repository/master/index.yaml && \
#     colcon mixin update && \
#     colcon metadata add default \
#       https://raw.githubusercontent.com/colcon/colcon-metadata-repository/master/index.yaml && \
#     colcon metadata update

# setup workspace
ENV ROS_OVERLAY /home/${USERNAME}/ibis_ws
RUN mkdir -p $ROS_OVERLAY/src
WORKDIR $ROS_OVERLAY

CMD ["bash"]
