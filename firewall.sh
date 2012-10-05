#!/bin/sh

r=`runningAsRoot`
if [ -n "$r" ]; then
	echo $r
	exit 1
fi

#Initialize
iptables -F 
iptables -X 

#Default policies
iptables -P INPUT DROP
iptables -P OUTPUT ACCEPT
iptables -P FORWARD DROP

#Stateful
iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT

#Drop anything from port 0
iptables -A INPUT -m tcp -p tcp --sport 0 -j DROP
iptables -A INPUT -m tcp -p tcp --dport 0 -j DROP
iptables -A INPUT -m udp -p udp --sport 0 -j DROP
iptables -A INPUT -m udp -p udp --dport 0 -j DROP

#Permit inbound ssh
iptables -A INPUT -m tcp -p tcp --dport ssh -j ACCEPT

#Permit outbound ssh
iptables -A INPUT -m tcp -p tcp --sport ssh -j ACCEPT

#Permit outbound FTP
iptables -A INPUT -m tcp -p tcp --sport ftp -j ACCEPT
iptables -A INPUT -m tcp -p tcp --sport ftp-data -j ACCEPT

#Permit outbound http
iptables -A INPUT -m tcp -p tcp --sport http -j ACCEPT 

#Permit outbound https
iptables -A INPUT -m tcp -p tcp --sport https -j ACCEPT 

#Allow DNS
iptables -A INPUT -m udp -p udp --sport domain -j ACCEPT


sudo iptables-save > /etc/iptables.rules
