#!/bin/bash
#KRB5
cp krb5.conf /etc/krb5.conf
cp kdc.conf /etc/krb5kdc/kdc.conf
#ldap
cp slapd.conf /usr/share/slapd/slapd.conf
cp ldap.conf  /etc/ldap/ldap.conf 
#system
cp nsswitch.conf /etc/nsswitch.conf 
#util
cp ldapscripts.conf /etc/ldapscripts/ldapscripts.conf
#systemctl restart krb5-kdc.service
#systemctl restart krb5-admin-server.service
#systemctl restart slapd.service
