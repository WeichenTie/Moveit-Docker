FROM osrf/ros:humble-desktop-full

WORKDIR /ws

RUN apt clean && rm -rf /var/lib/apt/lists/*

RUN sudo apt update

RUN sudo apt install -y git iputils-ping net-tools ufw tmux

RUN sudo apt install -y ros-humble-ros-gz \
    ros-humble-ros2-control \
    ros-humble-ros-ign-bridge \
    ros-humble-xacro \
    ros-humble-tf2-ros \
    ros-humble-tf2-tools \
    ros-humble-ros2-controllers \
    ros-humble-joint-state-publisher \
    ros-humble-joint-state-publisher-gui \
    ros-humble-moveit \
    ros-humble-rqt-joint-trajectory-controller \
    ros-humble-slam-toolbox \
    ros-humble-navigation2 \
    ros-humble-nav2-bringup \
    ros-humble-joint-trajectory-controller \
    ros-humble-joint-state-broadcaster \
    ros-$ROS_DISTRO-rmw-cyclonedds-cpp

RUN sudo apt-get install ros-humble-controller-manager

RUN sudo apt clean && rm -rf /var/lib/apt/lists/*

# Rosdep update
RUN rosdep update

# Source the ROS setup file
RUN echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> ~/.bashrc \
    echo "source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash" >> ~/.bashrc

ENV RMW_IMPLEMENTATION=rmw_cyclonedds_cpp
ENV DISPLAY=$DISPLAY
ENV QT_X11_NO_MITSHM=1 
ENV XAUTHORITY=$XAUTH 

WORKDIR /ws/tm2_ros2

RUN git clone https://github.com/WeichenTie/tm2_ros2.git -b humble

RUN /bin/bash -c "source /opt/ros/${ROS_DISTRO}/setup.bash && colcon build"

RUN echo "source /ws/tm2_ros2/install/setup.bash" >> ~/.bashrc

WORKDIR /ws
