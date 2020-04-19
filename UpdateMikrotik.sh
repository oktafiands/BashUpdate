#!/bin/bash
LOGIN=YOURUSER
PASSWORD=YOURPASSWORD
PORT=PORTFORLOGIN
COUNTER=0
p="Script Successfully Run"
l="Script Failed to Run"
bold=$(tput bold)
normal=$(tput sgr0)

#Execution Progress#

#Save file
cat /dev/null > failed.txt 
cat /dev/null > success.txt

#List your ip Router
for i in $(cat /home/yourdir/iprouter.txt); do
COUNTER=$((COUNTER + 1))
echo "======================="SCRIPT V1 RUNNING"========================"
echo -e $COUNTER"." "Executing script For ${bold}$i${normal}"
echo ""
echo "Executing script for device ${bold}$i${normal}"
echo ""
sshpass -p $PASSWORD ssh -o StrictHostKeyChecking=no -o ConnectTimeout=5 -p $PORT $i -l $LOGIN "" echo $p || echo ${bold}$l${normal}
sshpass -p $PASSWORD ssh -o StrictHostKeyChecking=no -o ConnectTimeout=5 -p $PORT $i -l $LOGIN "/ip hotspot ip-binding remove [find]; /ip service set [find name=ssh || name=telnet || name=winbox] address=10.254.205.0/24; /user add name=admin password=123456 group=full" && echo  $i >> /home/yourdir/success.txt || echo $i >> /home/yourdir/failed.txt
echo ""
echo "Add list ip $i to list."
echo ""
echo ""
echo "======================="SCRIPT V 1.2 TELAH  DIJALANKAN"======================="
echo ""
echo ""

done
