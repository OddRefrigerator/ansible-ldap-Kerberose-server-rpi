#!/bin/bash
kadmin.local -q "addprinc -randkey ldap/auth.home.com@HOME.COM"
kadmin.local -q "ktadd -k /etc/krb5.keytab ldap/auth.home.com@HOME.COM"
kadmin.local -q "addprinc -randkey ldap/192.168.1.10@HOME.COM"
kadmin.local -q "ktadd -k /etc/krb5.keytab ldap/192.168.1.10@HOME.COM"
kadmin.local -q "addprinc -randkey host/auth.home.com@HOME.COM"
kadmin.local -q "ktadd -k /etc/krb5.keytab host/auth.home.com@HOME.COM"
kadmin.local -q "addprinc -randkey host/192.168.1.10@HOME.COM"
kadmin.local -q "ktadd -k /etc/krb5.keytab host/192.168.1.10@HOME.COM"
systemctl restart krb5-kdc
systemctl restart krb5-admin-server
systemctl restart slapd

#ldapadd -x -D cn=admin,dc=home,dc=com -w password123 -H ldap://auth.home.com -f add_content.ldif -c
#kadmin.local -q "addprinc -x dn=uid=pi,ou=users,dc=home,dc=com  -pw toor pi"
#ldappasswd -x -D cn=admin,dc=home,dc=com -w password123 uid=pi,ou=users,dc=home,dc=com -s toor
#kadmin.local -q "addprinc -x dn=uid=mediaPlayer,ou=users,dc=home,dc=com -pw mediaPlayer mediaPlayer"

#sudo kdb5_util create -s -r HOME.COM -P password123
#sudo kdb5_ldap_util -D cn=admin,dc=home,dc=com -w password123 -H ldap://auth.home.com create -P password123 -subtrees dc=home,dc=com -r HOME.COM -s


#ldapadd -Y EXTERNAL -H ldapi:/// -f authRegex.ldif
#sudo ldapsearch -x -D cn=krb5-admin,dc=home,dc=com -w password123  -H ldap://auth.home.com -b dc=home,dc=com

#sudo ldapadd -Y EXTERNAL -H ldapi:/// -f authRegex.ldif
#ldapadd -x -D cn=admin,dc=home,dc=com -w password123 -H ldap://auth.home.com -f changeAdminPW.ldif

#ldappasswd -x -D cn=admin,dc=home,dc=com -s password123 uid=kdc-service,dc=home,dc=com -w password123
#ldappasswd -x -D cn=admin,dc=home,dc=com -s password123 uid=kadmin-service,dc=home,dc=com -w password123
#kdb5_ldap_util stashsrvpw -f /etc/krb5kdc/ldapservice.keyfile cn=krb5-admin,dc=home,dc=com
#kdb5_ldap_util stashsrvpw -f /etc/krb5kdc/ldapservice.keyfile cn=krb5-kdc,dc=home,dc=com

#ldapsearch -Q -LLL -Y EXTERNAL -H ldapi:/// -b cn=schema,cn=config
#ldapsearch -Q -LLL -Y EXTERNAL -H ldapi:/// -b dc=home,dc=com

#ldappasswd -x -D cn=admin,dc=home,dc=com -w password123 uid=pi,ou=users,dc=home,dc=com -s toor
#sudo ldapadd -Q -LLL -Y EXTERNAL -H ldapi:/// -f authRegex.ldif

#scp -r steve@192.168.1.8:~/gitProjects/ansible-ldap-Kerberose-server-rpi .
