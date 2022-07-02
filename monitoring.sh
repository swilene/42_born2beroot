#!/bin/bash

archi=$(	uname -a | awk '{print $0}')
cpu=$(		lscpu | grep 'Processeur' | awk '{print $2}')
vcpu=$(		lscpu | grep 'Socket' | awk '{print $2}')
memory=$(	free -m | grep 'Mem' | awk '{print $3"/"$2"MB"}')
divmemory=$(	free -m | grep 'Mem' | awk '{printf "%.2f", $3/$2*100}')
disku=$(	df -m --total | grep 'total' | awk '{print$3}')
disk=$(		df -h --total | grep 'total' | awk '{print "/"$2"b"}')
divdisk=$(	df -h --total | grep 'total'| awk '{printf "%.0f", $3/$2*100}')
load=$(		top -bn1 | grep '^%Cpu' | sed  -r 's/[a-z]{2},//g' | awk '{printf "%.1f", 100 - $5}')
boot=$(		who | awk 'NR==1 {print $3" "$4}')
lvmuse=$(	if [ $(lsblk | grep 'lvm' | wc -l) -eq 0 ]; then echo no; else echo yes; fi)
connexion=$(	netstat -natu | grep 'ESTABLISHED' | wc -l | awk '{print $0}')
user=$(		who | wc -l | awk '{print $0}')
IPv4=$(		hostname -I | awk '{print $0}')
MAC=$(		cat /sys/class/net/enp0s3/address | awk '{print $0}')
sudocmd=$(	wc -l /var/log/sudo/sudo.log | awk '{print $1/2}')

wall "
	#Architecture: $archi
	#CPU physical: $cpu
	#vCPU: $vcpu
	#Memory usage: $memory ($divmemory%)
	#Disk usage: $disku$disk ($divdisk%)
	#CPU load: $load%
	#Last boot: $boot
	#LVM use: $lvmuse
	#Connexions TCP: $connexion ESTABLISHED
	#User log: $user
	#Network: IP $IPv4($MAC)
	#Sudo: $sudocmd cmd
"
