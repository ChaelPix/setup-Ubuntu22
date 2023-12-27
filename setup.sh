#!/bin/bash

# #1: update and upgrade"
echo "#1: update and upgrade"
sudo apt update && sudo apt upgrade -y

#-----------------------ROS 2-----------------------
# #2: Ros 2 sources
echo "#2: Setup Ros2 sources"

sudo apt install -y software-properties-common
sudo add-apt-repository universe
sudo apt update && sudo apt install curl -y
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

# #3: Ros2 Humble and dependencies
echo "#3: Installing Ros2 Humble and dependencies"
sudo apt update
sudo apt upgrade -y
sudo apt install -y ros-humble-desktop-full
sudo apt install -y build-essential cmake git python3-colcon-common-extensions python3-pip python3-rosdep python3-vcstool wget apt-transport-https software-properties-common lsb-release

# 
echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc
source ~/.bashrc

# #4: Rosdep
echo "#4: Init Rosdep"
sudo rosdep init
rosdep update

# #5 : Ros2 extras
echo "#5: Installing ros2 extras"
sudo apt install -y gazebo11
sudo apt install -y ros-humble-navigation2 ros-humble-nav2-bringup


#-----------------------Tools----------------------
# #6 : Some tools
echo "#6: Installing some tools"

#--Terminator
sudo apt install -y terminator
cd ~
git clone --depth=1 https://github.com/twolfson/sexy-bash-prompt.git
cd sexy-bash-prompt
make install
source ~/.bashrc

#--Sexy bash prompt
echo "source ~/.bash_prompt" >> ~/.bashrc

#--Visual Studio Code
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
sudo apt install -y code

#--Microsoft office web
sudo snap install office365webdesktop --beta

#-----------------------Git----------------------
# #7 : Git Setup
echo "#7: Setup Git"
sudo apt install -y git

git config --global user.name "ChaelPix"
git config --global user.email "chael.pixel@gmail.com"

#-----------------------SSH----------------------
# #7 : SSH Setup
echo "#8: Setup SSH"
if [ ! -f ~/.ssh/id_rsa ]; then
  echo "Creating ssh key.."
  ssh-keygen -t rsa -b 4096 -C "chael.pixel@gmail.com" -N "" -f ~/.ssh/id_rsa
else
  echo "already a ssh key"
fi

#--alias showssh
echo "alias showssh='cat ~/.ssh/id_rsa.pub'" >> ~/.bashrc

#--git ssh
echo "Host *
  IdentityFile ~/.ssh/id_rsa" > ~/.ssh/config

#--ssh agent
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa

#-----------------------SSH----------------------
#--update bashrc
source ~/.bashrc
echo "Setup is finished, please close this terminal."