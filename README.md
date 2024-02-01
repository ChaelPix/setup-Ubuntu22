# Setup-Ubuntu22

# Reminders of steps to do when install a fresh ubuntu.

+ Launch setup:
<pre>sudo chmod +x setup.sh
./setup.sh</pre>

+ Copy ssh key:
<pre>ssh-copy-id user@ip_addr </pre>

+ edit su bashrc:
<pre>sudo nano /root/.bashrc</pre>

+ remove cached folders git
<pre>git rm -r --cached</pre>

# Change Network Tool 
+ Setup ChangeWifi shortcut :
<pre>nmcli con show</pre>
- Récupérer les uuid des réseaux, les mettre dans changewifi.sh
<pre>chmod +x create_changewifi_alias.sh
./ create_changewifi_alias.sh</pre>
- Pour changer de réseau wifi, faire changewifi x
où x représente le réseau, par défaut h = home, r = robot.