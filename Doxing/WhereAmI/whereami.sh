#!/bin/bash

#       CURRENT DATE
DATE=`date '+%Y-%m-%d %H:%M:%S'`

#       PUBLIC IP ADDR
PUBLIC_ADDR=`curl ifconfig.me`
cd logs
#       WHOIS ABOUT OUR NETWORK
touch "$DATE@$PUBLIC_ADDR"
echo "---------------------------------------------------------" >> "$DATE@$PUBLIC_ADDR"
echo "----------------------    WHOIS    ----------------------" >> "$DATE@$PUBLIC_ADDR"
echo "---------------------------------------------------------" >> "$DATE@$PUBLIC_ADDR"
whois $PUBLIC_ADDR >> "$DATE@$PUBLIC_ADDR"

#       THANKS HAK5 FOR SHOWING ME WHAT AWK AND CUT DO
ETHERNET_INTERFACE="eno1"
WIFI_INTERFACE="wlp7s0"
LOCAL_NETWORK_ETHERNET_ADDR=$(ip addr show | grep $ETHERNET_INTERFACE | grep inet | awk '{print $2}' | cut -d "/" -f 1)
LOCAL_NETWORK_ETHERNET_MASK=$(ip addr show | grep $ETHERNET_INTERFACE | grep inet | awk '{print $2}' | cut -d "/" -f 2)
LOCAL_NETWORK_WIFI_ADDR=$(ip addr show | grep $WIFI_INTERFACE | grep inet | awk '{print $2}' | cut -d "/" -f 1)
LOCAL_NETWORK_WIFI_MASK=$(ip addr show | grep $WIFI_INTERFACE | grep inet | awk '{print $2}' | cut -d "/" -f 2)

echo "-------------------------------------------------------------------------------" >> "$DATE@$PUBLIC_ADDR"
echo "----------------------    LOCAL DISCOVER SCAN (NMAP)    ----------------------" >> "$DATE@$PUBLIC_ADDR"
echo "-------------------------------------------------------------------------------" >> "$DATE@$PUBLIC_ADDR"
#	FIRST WE DO A QUICK DISCOVER SCAN (JUST IN CASE WE RAN OUT OF TIME)

if [ "$LOCAL_NETWORK_ETHERNET_ADDR" != "127.0.0.1" ];
then
        echo "" >> "$DATE@$PUBLIC_ADDR"
        echo ">> SCANNING ETHERNET NETWORK" >> "$DATE@$PUBLIC_ADDR"
        sudo nmap -sP $LOCAL_NETWORK_ETHERNET_ADDR/$LOCAL_NETWORK_ETHERNET_MASK >> "$DATE@$PUBLIC_ADDR"
elif [ "$LOCAL_NETWORK_WIFI_ADDR" != "127.0.0.1" ];
then
        echo "" >> "$DATE@$PUBLIC_ADDR"
        echo ">> SCANNING WIFI NETWORK" >> "$DATE@$PUBLIC_ADDR"
        sudo nmap -sP $LOCAL_NETWORK_WIFI_ADDR/$LOCAL_NETWORK_WIFI_MASK >> "$DATE@$PUBLIC_ADDR"
else
        echo "" >> "$DATE@$PUBLIC_ADDR"
        echo ">> COULDN'T FIND NETWORK, ANYWAY THEESE ARE BOTH WIFI AND ETHERNET SCANS"
        sudo nmap -sP $LOCAL_NETWORK_ETHERNET_ADDR/$LOCAL_NETWORK_ETHERNET_MASK >> "$DATE@$PUBLIC_ADDR"
        sudo nmap -sP $LOCAL_NETWORK_WIFI_ADDR/$LOCAL_NETWORK_WIFI_MASK >> "$DATE@$PUBLIC_ADDR"
fi

echo "" >> "$DATE@$PUBLIC_ADDR"
echo "-------------------------------------------------------------------------------" >> "$DATE@$PUBLIC_ADDR"
echo "----------------------    LOCAL AGRESSIVE SCAN (NMAP)    ----------------------" >> "$DATE@$PUBLIC_ADDR"
echo "-------------------------------------------------------------------------------" >> "$DATE@$PUBLIC_ADDR"
#	THEN WE LEAVE THE SCRIPT RUNNING AN AGRESSIVE SCAN THAT MAY OR MAY NOT BE FINNISHED

if [ "$LOCAL_NETWORK_ETHERNET_ADDR" != "127.0.0.1" ];
then
	echo "" >> "$DATE@$PUBLIC_ADDR"
	echo ">> SCANNING ETHERNET NETWORK" >> "$DATE@$PUBLIC_ADDR"
	nmap -A $LOCAL_NETWORK_ETHERNET_ADDR/$LOCAL_NETWORK_ETHERNET_MASK >> "$DATE@$PUBLIC_ADDR"
elif [ "$LOCAL_NETWORK_WIFI_ADDR" != "127.0.0.1" ];
then
	echo "" >> "$DATE@$PUBLIC_ADDR"
	echo ">> SCANNING WIFI NETWORK" >> "$DATE@$PUBLIC_ADDR"
	nmap -A $LOCAL_NETWORK_WIFI_ADDR/$LOCAL_NETWORK_WIFI_MASK >> "$DATE@$PUBLIC_ADDR"
else
	echo "" >> "$DATE@$PUBLIC_ADDR"
	echo ">> COULDN'T FIND NETWORK, ANYWAY THEESE ARE BOTH WIFI AND ETHERNET SCANS"
	nmap -A $LOCAL_NETWORK_ETHERNET_ADDR/$LOCAL_NETWORK_ETHERNET_MASK >> "$DATE@$PUBLIC_ADDR"
	nmap -A $LOCAL_NETWORK_WIFI_ADDR/$LOCAL_NETWORK_WIFI_MASK >> "$DATE@$PUBLIC_ADDR"
fi
cd ..