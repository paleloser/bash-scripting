#!/bin/bash

#       CURRENT DATE
DATE=`date '+%Y-%m-%d'`
#       PUBLIC IP ADDR
PUBLIC_ADDR=`curl ifconfig.me`

FILENAME="$DATE@$PUBLIC_ADDR"
cd logs

#	FUCK IT, THIS IS EASIER
LOGS=$(ls -l | awk '{print $9}')

function writeover {
	touch "$FILENAME"

	#       WHOIS ABOUT OUR NETWORK
	echo "---------------------------------------------------------" >> "$FILENAME"
	echo "----------------------    WHOIS    ----------------------" >> "$FILENAME"
	echo "---------------------------------------------------------" >> "$FILENAME"
	whois $PUBLIC_ADDR >> "$FILENAME"

	#       THANKS HAK5 FOR SHOWING ME WHAT AWK AND CUT DO
	ETHERNET_INTERFACE="eno1"
	WIFI_INTERFACE="wlp7s0"
	LOCAL_NETWORK_ETHERNET_ADDR=$(ip addr show | grep $ETHERNET_INTERFACE | grep inet | awk '{print $2}' | cut -d "/" -f 1)
	LOCAL_NETWORK_ETHERNET_MASK=$(ip addr show | grep $ETHERNET_INTERFACE | grep inet | awk '{print $2}' | cut -d "/" -f 2)
	LOCAL_NETWORK_WIFI_ADDR=$(ip addr show | grep $WIFI_INTERFACE | grep inet | awk '{print $2}' | cut -d "/" -f 1)
	LOCAL_NETWORK_WIFI_MASK=$(ip addr show | grep $WIFI_INTERFACE | grep inet | awk '{print $2}' | cut -d "/" -f 2)

	echo "-------------------------------------------------------------------------------" >> "$FILENAME"
	echo "----------------------    LOCAL DISCOVER SCAN (NMAP)    ----------------------" >> "$FILENAME"
	echo "-------------------------------------------------------------------------------" >> "$FILENAME"
	#	FIRST WE DO A QUICK DISCOVER SCAN (JUST IN CASE WE RAN OUT OF TIME)

	if [ "$LOCAL_NETWORK_ETHERNET_ADDR" != "127.0.0.1" ];
	then
		echo "" >> "$FILENAME"
		echo ">> SCANNING ETHERNET NETWORK" >> "$FILENAME"
		sudo nmap -sP $LOCAL_NETWORK_ETHERNET_ADDR/$LOCAL_NETWORK_ETHERNET_MASK >> "$FILENAME"
	elif [ "$LOCAL_NETWORK_WIFI_ADDR" != "127.0.0.1" ];
	then
		echo "" >> "$FILENAME"
		echo ">> SCANNING WIFI NETWORK" >> "$FILENAME"
		sudo nmap -sP $LOCAL_NETWORK_WIFI_ADDR/$LOCAL_NETWORK_WIFI_MASK >> "$FILENAME"
	else
		echo "" >> "$FILENAME"
		echo ">> COULDN'T FIND NETWORK, ANYWAY THEESE ARE BOTH WIFI AND ETHERNET SCANS"
		sudo nmap -sP $LOCAL_NETWORK_ETHERNET_ADDR/$LOCAL_NETWORK_ETHERNET_MASK >> "$FILENAME"
		sudo nmap -sP $LOCAL_NETWORK_WIFI_ADDR/$LOCAL_NETWORK_WIFI_MASK >> "$FILENAME"
	fi

	echo "-------------------------------------------------------------------------------" >> "$FILENAME"
	echo "----------------------    LOCAL AGRESSIVE SCAN (NMAP)    ----------------------" >> "$FILENAME"
	echo "-------------------------------------------------------------------------------" >> "$FILENAME"
	#	THEN WE LEAVE THE SCRIPT RUNNING AN AGRESSIVE SCAN THAT MAY OR MAY NOT BE FINNISHED

	if [ "$LOCAL_NETWORK_ETHERNET_ADDR" != "127.0.0.1" ];
	then
		echo "" >> "$FILENAME"
		echo ">> SCANNING ETHERNET NETWORK" >> "$FILENAME"
		nmap -A $LOCAL_NETWORK_ETHERNET_ADDR/$LOCAL_NETWORK_ETHERNET_MASK >> "$FILENAME"
	elif [ "$LOCAL_NETWORK_WIFI_ADDR" != "127.0.0.1" ];
	then
		echo "" >> "$FILENAME"
		echo ">> SCANNING WIFI NETWORK" >> "$FILENAME"
		nmap -A $LOCAL_NETWORK_WIFI_ADDR/$LOCAL_NETWORK_WIFI_MASK >> "$FILENAME"
	else
		echo "" >> "$FILENAME"
		echo ">> COULDN'T FIND NETWORK, ANYWAY THEESE ARE BOTH WIFI AND ETHERNET SCANS"
		nmap -A $LOCAL_NETWORK_ETHERNET_ADDR/$LOCAL_NETWORK_ETHERNET_MASK >> "$FILENAME"
		nmap -A $LOCAL_NETWORK_WIFI_ADDR/$LOCAL_NETWORK_WIFI_MASK >> "$FILENAME"
	fi
	cd ..
	exit
}

for i in $LOGS; do
	if [ $i == "$FILENAME" ]; 
	then
		if [ "$1" == "-r" ];
		then
			echo "REPLACING TODAY'S SCAN"
			sudo rm -r "$FILENAME"
			writeover
		elif [ "$1" == "-a" ];
		then
			echo "GENERATING A DUPLICATED SCAN"
			FILENAME+=" (D)"
			writeover
		fi
		echo "TODAY'S SCAN ALREADY DONE, SKIPPING"		
		exit
	fi
done

writeover

