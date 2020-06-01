#!/bin/bash

#Change logging level
sudo ldapmodify -Q -Y EXTERNAL -H ldapi:/// -f ../ldif/logging.ldif

#Set password for admin
slapAdmin=password123
pass=$(sudo slappasswd -s $slapAdmin -h {SSHA})
sed -r "s/olcRootPW: oldPassword/olcRootPW: $pass/g" ../ldif/newPassword.ldif
sudo ldapsearch -H ldapi:// -LLL -Q -Y EXTERNAL -b "cn=config" "(olcRootDN=*)" dn olcRootDN olcRootPW | tee ../ldif/newpasswd.ldif

#Install kerberose schema
sudo cp /usr/share/doc/krb5-kdc-ldap/kerberos.schema.gz /etc/ldap/schema/
sudo gunzip /etc/ldap/schema/kerberos.schema.gz
sudo ldap-schema-manager -i /etc/ldap/schema/kerberos.schema

#Apply ldif for krb5
sudo ldapmodify -Q -Y EXTERNAL -H ldapi:/// -f ../ldif/krb5Index.ldif -c
sudo ldapadd -Q -Y EXTERNAL -H ldapi:/// -f ../ldif/krb5perms.ldif -c
sudo ldapadd -x -D cn=admin,dc=home,dc=com -w password123 -H ldap://auth.home.com -f ../ldif/krb5admin.ldif -c

#Set password and stash in service.kefile
sudo ldappasswd -x -D cn=admin,dc=home,dc=com -w password123 -s password123 uid=kdc-service,dc=home,dc=com
sudo ldappasswd -x -D cn=admin,dc=home,dc=com -w password123 -s password123 uid=kadmin-service,dc=home,dc=com
sudo kdb5_ldap_util stashsrvpw -f /etc/krb5kdc/ldapservice.keyfile uid=kdc-service,dc=home,dc=com
sudo kdb5_ldap_util stashsrvpw -f /etc/krb5kdc/ldapservice.keyfile uid=kadmin-service,dc=home,dc=com
sudo systemctl restart slapd

#Create krb5 container
sudo sed -i 's/#database_module = openldap_ldapconf/database_module = openldap_ldapconf/g' /etc/krb5.conf
sudo kdb5_ldap_util -D cn=admin,dc=home,dc=com -w password123 -H ldap://auth.home.com create -subtrees dc=home,dc=com -P password123 -r HOME.COM -s

