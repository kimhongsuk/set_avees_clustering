#!/bin/bash
# environment.sh

echo -n "[AVEES-Cluster] Enter node-index number : "
read node_index

# Check that node_index is integer type
case ${node_index} in
''|*[!0-9]*) 
	echo "[AVEES-Cluster] You didn't enter number"
	exit 1 ;;
*)
	echo_head="Node-${node_index}"
	echo "[${echo_head}] Set 'Computing Node' environment for jetson orin nano - jetpack 5.x" ;;
esac

# Update & upgrade apt repository
sudo apt update
sudo apt upgrade -y

# Install ROS2 Foxy
sudo apt install curl -y
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
sudo apt update && sudo apt upgrade -y
sudo apt install ros-foxy-desktop -y
sudo apt install ros-dev-tools -y

# Set ROS2 environment
cd ~/
mkdir -p ros2_ws/src
cd ~/ros2_ws && colcon_build

# Set Alias in ~/.bashrc
echo "\n" >> ~/.bahsrc
echo "# Show Node's Number" >> ~/.bashrc
echo "echo "Node ${node_index}"" >> ~/.bashrc

echo "\n" >> ~/.bahsrc
echo "# Setup ROS2 environment" >> ~/.bashrc
echo "source /opt/ros/foxy/setup.bash" >> ~/.bashrc
echo "source ~/ros2_ws/install/setup.bash" >> ~/.bashrc
echo "export ROS_DOMAIN_ID=102" >> ~/.bashrc

echo "\n" >> ~/.bahsrc
echo "# Set more alias to ROS2" >> ~/.bashrc
echo "alias cm='cd ~/ros2_ws; colcon build --symlink-install; source install/setup.bash'" >> ~/.bashrc
echo "alias sb='cd ~/ros2_ws; source install/setup.bash'" >> ~/.bashrc

echo "\n" >> ~/.bahsrc
echo "# Github alias" >> ~/.bashrc
echo "alias cs='cd ~/ros2_ws/src/clustering_sensor'" >> ~/.bashrc

# GigE Camera
cd ~/set_avees_clustering
wget https://downloads.alliedvision.com/Vimba_v6.0_ARM64.tgz
sudo tar -xzf Vimba_v6.0_ARM64.tgz -C /opt
cd /opt/Vimba_6_0/VimbaGigETL
sudo ./Install.sh
sudo apt install ros-foxy-diagnostic-updater -y
sudo apt install ros-foxy-camera-info-manager -y
sudo apt install ros-foxy-vision-msgs -y

# Install Open-vSwitch
cd ~/.
sudo apt install automake python-six libssl-dev -y
git clone -b branch-2.8 --single-branch https://github.com/openvswitch/ovs.git
cd ~/ovs
./boot.sh
./configure
make -j6
sudo make install
