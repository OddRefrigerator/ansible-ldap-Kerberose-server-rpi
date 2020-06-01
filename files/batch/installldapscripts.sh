#!/bin/bash
apt install -y ldapscripts 
#CHANGE THIS--> Password should be ENV VAR or prog switch
sh -c "echo -n 'password123' > /etc/ldapscripts/ldapscripts.passwd"
chmod 400 /etc/ldapscripts/ldapscripts.passwd
cp ../conf/ldapscripts.conf /etc/ldapscripts/ldapscripts.conf
