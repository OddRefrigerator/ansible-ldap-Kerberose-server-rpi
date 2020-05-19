#!/bin/bash

#FQDN
kadmin.local -q "addprinc -randkey host/auth.home.com@HOME.COM"
kadmin.local -q "addprinc -randkey ldap/auth.home.com@HOME.COM"
kadmin.local -q "addprinc -randkey nfs/auth.home.com@HOME.COM"
kadmin.local -q "ktadd -k /etc/krb5.keytab host/auth.home.com@HOME.COM"
kadmin.local -q "ktadd -k /etc/krb5.keytab ldap/auth.home.com@HOME.COM"
kadmin.local -q "ktadd -k /etc/krb5.keytab nfs/auth.home.com@HOME.COM"
#IP
kadmin.local -q "addprinc -randkey host/192.168.1.10@HOME.COM"
kadmin.local -q "addprinc -randkey ldap/192.168.1.10@HOME.COM"
kadmin.local -q "addprinc -randkey nfs/192.168.1.10@HOME.COM"
kadmin.local -q "ktadd -k /etc/krb5.keytab host/192.168.1.10@HOME.COM"
kadmin.local -q "ktadd -k /etc/krb5.keytab ldap/192.168.1.10@HOME.COM"
kadmin.local -q "ktadd -k /etc/krb5.keytab nfs/192.168.1.10@HOME.COM"

kadmin.local -q "addprinc -randkey kdc-service@HOME.COM"
kadmin.local -q "addprinc -randkey kadmin-service@HOME.COM"
kadmin.local -q "ktadd -k /etc/krb5.keytab kdc-service@HOME.COM"
kadmin.local -q "ktadd -k /etc/krb5.keytab kadmin-service@HOME.COM"

# kdb5_ldap_util stashsrvpw -f /etc/krb5kdc/ldap.keyfile "uid=root,dc=home,dc=com"

# sudo kdb5_ldap_util -D cn=admin,dc=auth,dc=home,dc=com create -s -r HOME.COM -H ldapi:/// 


kadmin.local -q "addprinc pi@HOME.COM"
kadmin.local -q "ktadd -k /etc/krb5.keytab pi@HOME.COM"
