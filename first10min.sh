####################################################################################################################### 
# first10min.sh
# by darkmage
# x: @evildojo666
# https://www.evildojo.com
# based on: https://blog.codelitt.com/my-first-10-minutes-on-a-server-primer-for-securing-ubuntu/
####################################################################################################################### 

USERNAME="$1";
SSH_KEYFILE="$2";

if [ -z "$USERNAME" ]; then
    echo "Usage: $0 <username> [ssh_keyfile]";
    exit 1;
fi

#if [ -z "$SSH_KEYFILE" ]; then
#    echo "Usage: $0 <username> [ssh_keyfile]";
#    exit 1;
#fi

# check that keyfile exists
if [ ! -f "$SSH_KEYFILE" ]; then
    echo "\033[31mError\033[0m: $SSH_KEYFILE does not exist";
    echo "Proceeding without adding ssh key";
    SSH_KEYFILE="";
fi

# change root password
passwd;

# basics
apt-get update;
apt-get upgrade -y;
apt-get install -y tmux zsh git rsync build-essential htop fail2ban ufw python3-pip ca-certificates curl gnupg \
    unattended-upgrades lsb-release neovim parallel btop fortune cowsay;

# configure user
useradd $USERNAME;
mkdir -p /home/$USERNAME/.ssh;
chmod 700 /home/$USERNAME/.ssh;
usermod -s /usr/bin/zsh $USERNAME;
cat $SSH_KEYFILE >> /home/$USERNAME/.ssh/authorized_keys;
chmod 400 /home/$USERNAME/.ssh/authorized_keys;
chown $USERNAME:$USERNAME /home/$USERNAME -R ;
passwd $USERNAME;
usermod -aG sudo $USERNAME;

# configure sshd
sed -i s/PermitRootLogin/#PermitRootLogin/ /etc/ssh/sshd_config;
if [[ $SSH_KEYFILE != "" ]]; then
    sed -i "s/PasswordAuthentication/#PasswordAuthentication/" /etc/ssh/sshd_config;
    echo -e "PasswordAuthentication no\n" >> /etc/ssh/sshd_config; 
fi
echo -e "PermitRootLogin no\nAllowUsers $USERNAME\n" >> /etc/ssh/sshd_config; 

service ssh restart;
ufw allow 22;
ufw disable;
ufw enable; 

# my own extras
# disable printing IP address on login
touch /home/$USERNAME/.hushlogin;

# install golang runtime
FILENAME="go1.23.3.linux-amd64.tar.gz";
URL="https://go.dev/dl/$FILENAME";
wget $URL;
rm -rf /usr/local/go;
tar -C /usr/local -xzf $FILENAME;

# install mullvad
#wget https://mullvad.net/en/download/app/deb/latest -O mullvad.deb;
#dpkg -i mullvad.deb;

# install do-agent
#curl -sSL https://repos.insights.digitalocean.com/install.sh | bash;

# install qs
#pip3 install queryswap;

# install docker
#mkdir -p /etc/apt/keyrings;
#curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg;
#echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null;
#apt update;
#apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin;

# for fun
# install pokemonsay



