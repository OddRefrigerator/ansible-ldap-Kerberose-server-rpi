#!/bin/bash
kadmin.local -q "addprinc -randkey ldap/auth.home.com@HOME.COM"
kadmin.local -q "ktadd -k /etc/krb5.keytab ldap/auth.home.com@HOME.COM"
kadmin.local -q "addprinc -randkey ldap/192.168.1.10@HOME.COM"
kadmin.local -q "ktadd -k /etc/krb5.keytab ldap/192.168.1.10@HOME.COM"
kadmin.local -q "addprinc -randkey host/auth.home.com@HOME.COM"
kadmin.local -q "ktadd -k /etc/krb5.keytab host/auth.home.com@HOME.COM"
kadmin.local -q "addprinc -randkey host/192.168.1.10@HOME.COM"
kadmin.local -q "ktadd -k /etc/krb5.keytab host/192.168.1.10@HOME.COM"

sudo kadmin.local -q "addprinc -randky krb5-kdc"
sudo kadmin.local -q "addprinc -randky krb5-admin"

sudo kadmin.local -q "addprinc -pw toor pi"
sudo kadmin.local -q "addprinc -pw mediaPlayer mediaPlayer"

ldapadd -x -D cn=admin,dc=home,dc=com -w password123 -H ldap://auth.home.com -f add_content.ldif -c
ldapsearch -Q -LLL -Y EXTERNAL -H ldapi:/// -b dc=home,dc=com

#check a_dn_pat: gidNumber=0+uidNumber=0,cn=peercred,cn=external,cn=auth
#ldapadd -x -D cn=admin,dc=home,dc=com -w password123 -H ldap://auth.home.com -f changeAdminPW.ldif
#kdb5_ldap_util stashsrvpw -f /etc/krb5kdc/ldapservice.keyfile cn=krb5-admin,dc=home,dc=com
#kdb5_ldap_util stashsrvpw -f /etc/krb5kdc/ldapservice.keyfile cn=krb5-kdc,dc=home,dc=com
#ldapsearch -Q -LLL -Y EXTERNAL -H ldapi:/// -b cn=schema,cn=config