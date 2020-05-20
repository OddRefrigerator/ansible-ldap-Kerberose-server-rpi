#!/bin/bash
#Change logging
sudo ldapmodify -Q -Y EXTERNAL -H ldapi:/// -f logging.ldif

#Install kerberose schema
sudo cp /usr/share/doc/krb5-kdc-ldap/kerberos.schema.gz /etc/ldap/schema/
sudo gunzip /etc/ldap/schema/kerberos.schema.gz
sudo ldap-schema-manager -i /etc/ldap/schema/kerberos.schema

#apply ldif for krb5
sudo ldapmodify -Q -Y EXTERNAL -H ldapi:/// -f krb5Index.ldif -c
sudo ldapadd -x -D cn=admin,dc=home,dc=com -w password123 -H ldap://auth.home.com -f krb5admin.ldif -c
sudo ldapadd -Q -Y EXTERNAL -H ldapi:/// -f krb5perms.ldif -c
#sudo ldapadd -Q -Y EXTERNAL -H ldapi:/// -f krb5admin.ldif -c
#sudo ldapsearch -Y EXTERNAL -H ldapi:/// -b dc=home,dc=com

#Set password and stash in service.kefile
sudo ldappasswd -x -D cn=admin,dc=home,dc=com -w password123 -s password123 uid=kdc-service,dc=home,dc=com
sudo ldappasswd -x -D cn=admin,dc=home,dc=com -w password123 -s password123 uid=kadmin-service,dc=home,dc=com
sudo kdb5_ldap_util stashsrvpw -f /etc/krb5kdc/ldapservice.keyfile uid=kdc-service,dc=home,dc=com
sudo kdb5_ldap_util stashsrvpw -f /etc/krb5kdc/ldapservice.keyfile uid=kadmin-service,dc=home,dc=com
sudo systemctl restart slapd

#Create krb5 container
sudo sed -i 's/#database_module = openldap_ldapconf/database_module = openldap_ldapconf/g' /etc/krb5.conf
sudo kdb5_ldap_util -D cn=admin,dc=home,dc=com -w password123 -H ldap://auth.home.com create -subtrees dc=home,dc=com -P password123 -r HOME.COM -s

#Add content
#sudo ldapadd -Q -Y EXTERNAL -H ldapi:/// -f add_content.ldif -c
#sudo ldapsearch -Y EXTERNAL -H ldapi:/// -b dc=home,dc=com
#slapcat -v -b dc=home,dc=com -l backup.ldif

