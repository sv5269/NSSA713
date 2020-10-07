#!/bin/bash
#Author: Sneha Vasudeva Rao
#Date: 09/29/2020
#Purpose: check if security policies are implemented correctly

clear
echo "---------------------------------------"
echo "*****Beginning Test*****"
echo "            5"
echo "            4"
echo "            3"
echo "            2"
echo "            1"

state=$(ip a | grep ens33 | grep -oP 'state.*' | awk '{print $2}')
if [ "$state" == "UP" ]
then 
    echo "Interface is UP"
else
    echo "Interface is down"
fi
 
gateway=$(route -n | sed -e 1,2d | head -1 | awk '{print $2}')
echo "The default gateway is $gateway"

ping -c 4 $gateway &> /dev/null
if [ $? -eq 0 ]
then 
    echo "Connection to default gateway is SUCCESSFUL"
else
    echo "Connection to default gateway FAILED"
fi

ping -c 4 8.8.8.8 &> /dev/null
if [ $? -eq 0 ]
then
    echo "Remote connection SUCCEDED!"
else
    echo "Remote connectio FAILED!"
fi

ping -c 4 www.google.com &> /dev/null
if [ $? -eq 0 ]
then
    echo "DNS resolution SUCCEDED!"
else
    echo "DNS resolution FAILED!"
fi


echo "Checking for User accounts"

accounts=$(getent passwd {1000..6000})
if [ "$accounts" != "" ]
then
    echo "User accounts found"
    echo $accounts
else
    echo "No User accounts found"
fi

echo "List of running services"
systemctl list-units --type=service | grep running
echo "-------------------------------------------------------------------"

echo "List of open ports"
lsof -i -P -n | grep LISTEN
echo "-------------------------------------------------------------------"

echo " Checking contents of host file"
hosts=$(cat /etc/hosts | awk '{print $1}')
hosts=($hosts)
for i in "${hosts[@]}"
do 
    if [ "$i" != "127.0.0.1" ] && [ "$i" != "::1" ]
    then
        echo "Extra entries found in the host file"
    else
        extra=0
    fi
done
if [ $extra -eq 0 ]
then
    echo "No extra enteries found in host file"
fi
echo "-------------------------"
echo "***** Test Complete. ****"
echo "--------------------------"
