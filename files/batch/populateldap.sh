#!/bin/bash
export REALM="HOME.COM"
export krb5DBpw="password123"
export krb5admpw="password123"
export krb5kdcldap="password123"
export krb5adminldap="password123"

#Change logging level
sudo ldapmodify -Q -Y EXTERNAL -H ldapi:/// -f ../ldif/logging.ldif

#Install kerberose schema
sudo cp /usr/share/doc/krb5-kdc-ldap/kerberos.schema.gz /etc/ldap/schema/
sudo gunzip /etc/ldap/schema/kerberos.schema.gz
sudo ldap-schema-manager -i /etc/ldap/schema/kerberos.schema

#Set password for admin
#CHANGE THIS--> Password should be set dynamicaly from ENV or prog var
#slapAdmin=password123
pass=$(sudo slappasswd -s $slapAdmin -h {SSHA})
echo 'olcRootPW: '$pass >> ../ldif/newPassword.ldif
sudo ldapmodify -Q -Y EXTERNAL -H ldapi:/// -f ../ldif/newPassword.ldif

#Apply ldif for krb5
sudo ldapmodify -Q -Y EXTERNAL -H ldapi:/// -f ../ldif/krb5Index.ldif -c
sudo ldapadd -Q -Y EXTERNAL -H ldapi:/// -f ../ldif/krb5perms.ldif -c
#CHANGE THIS--> Password should be set dynamicaly from ENV or prog var
sudo ldapadd -x -D cn=admin,dc=home,dc=local -w $slapAdmin -H ldap://auth.home.local -f ../ldif/krb5admin.ldif -c

#Set password and stash in service.kefile
#CHANGE THIS--> Password should be set dynamicaly from ENV or prog var
sudo ldappasswd -x -D cn=admin,dc=home,dc=local -w $slapAdmin -s $ldapPassword uid=kdc-service,dc=home,dc=local
#CHANGE THIS--> Password should be set dynamicaly from ENV or prog var
sudo ldappasswd -x -D cn=admin,dc=home,dc=local -w $slapAdmin -s $ldapPassword uid=kadmin-service,dc=home,dc=local
#CHANGE THIS--> no option to script password input
sudo kdb5_ldap_util stashsrvpw -f /etc/krb5kdc/ldapservice.keyfile uid=kdc-service,dc=home,dc=local
sudo kdb5_ldap_util stashsrvpw -f /etc/krb5kdc/ldapservice.keyfile uid=kadmin-service,dc=home,dc=local
sudo systemctl restart slapd

#Create krb5 container
sudo sed -i 's/#database_module = openldap_ldapconf/database_module = openldap_ldapconf/g' /etc/krb5.conf
#CHANGE THIS--> Password should be set dynamicaly from ENV or prog var
sudo kdb5_ldap_util -D cn=admin,dc=home,dc=local -w $slapAdmin -H ldap://auth.home.local create -subtrees cn=krbContainer,dc=home,dc=local -P $ldapPassword -r home.local -s



