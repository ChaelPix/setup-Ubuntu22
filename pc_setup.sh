echo "#1: update and upgrade"
echo $sudo_password | sudo -S apt update && echo $sudo_password | sudo -S apt upgrade -y

#-----------------------ROS 2-----------------------
# #2: Ros 2 sources
echo "#2: Setup Ros2 sources"

echo $sudo_password | sudo -S apt install -y software-properties-common
echo $sudo_password | sudo -S add-apt-repository universe -y
echo $sudo_password | sudo -S apt update && echo $sudo_password | sudo -S apt install curl -y
echo $sudo_password | sudo -S curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | echo $sudo_password | sudo -S tee /etc/apt/sources.list.d/ros2.list > /dev/null

# #3: Ros2 Humble and dependencies
echo "#3: Installing Ros2 Humble and dependencies"
echo $sudo_password | sudo -S apt update
echo $sudo_password | sudo -S apt upgrade -y
echo $sudo_password | sudo -S apt install -y ros-humble-desktop-full
echo $sudo_password | sudo -S apt install -y build-essential cmake git python3-colcon-common-extensions python3-pip python3-rosdep python3-vcstool wget apt-transport-https software-properties-common lsb-release

echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc
echo "alias pixxdomain='export ROS_DOMAIN_ID=33'" >> ~/.bashrc

# #4: Rosdep
echo "#4: Init Rosdep"
echo $sudo_password | sudo -S rosdep init
rosdep update

# #5 : Ros2 extras
echo "#5: Installing ros2 extras"
echo $sudo_password | sudo -S apt install -y gazebo11
echo $sudo_password | sudo -S apt install -y ros-humble-navigation2 ros-humble-nav2-bringup

#-----------------------Tools----------------------
# #6 : Some tools
echo "#6: Installing some tools"

#--Terminator
echo $sudo_password | sudo -S apt install -y terminator

#--Sexy Bash Prompt
git clone --depth=1 https://github.com/twolfson/sexy-bash-prompt.git ~/sexy-bash-prompt
cd ~/sexy-bash-prompt
make install
source ~/.bashrc
cd ~

#--Visual Studio Code
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | echo $sudo_password | sudo -S apt-key add -
echo $sudo_password | sudo -S add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
echo $sudo_password | sudo -S apt install -y code

#--tree
echo $sudo_password | sudo -S apt install -y tree

#-----------------------Git----------------------
# #7 : Git Setup
echo "#7: Setup Git"
echo $sudo_password | sudo -S apt install -y git

git config --global user.name "$guser"
git config --global user.email "$email"

#-----------------------SSH----------------------
# #8 : SSH Setup
echo "#8: Setup SSH"
if [ ! -f ~/.ssh/id_rsa ]; then
  echo "Creating ssh key.."
  ssh-keygen -t rsa -b 4096 -C "$email" -N "" -f ~/.ssh/id_rsa
  echo "ssh key created, you can use 'showssh' to show it"
else
  echo "SSH key already exists."
fi

echo "alias showssh='cat ~/.ssh/id_rsa.pub'" >> ~/.bashrc

echo "Host *
  IdentityFile ~/.ssh/id_rsa" > ~/.ssh/config

eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa

#-----------------------Graphic Drivers----------------------
echo "#9:  Installing graphic drivers"
echo $sudo_password | sudo -S ubuntu-drivers autoinstall

#-----------------------END----------------------
source ~/.bashrc
echo "Setup is finished, please close this terminal."