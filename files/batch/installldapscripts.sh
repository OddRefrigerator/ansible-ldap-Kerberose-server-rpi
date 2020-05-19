#!/bin/bash
apt install -y ldapscripts 
sh -c "echo -n 'password123' > /etc/ldapscripts/ldapscripts.passwd"
chmod 400 /etc/ldapscripts/ldapscripts.passwd
