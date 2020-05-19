#!/bin/bash
#Change logging
sudo ldapmodify -Q -Y EXTERNAL -H ldapi:/// -f logging.ldif

#Install kerberose schema
sudo cp /usr/share/doc/krb5-kdc-ldap/kerberos.schema.gz /etc/ldap/schema/
sudo gunzip /etc/ldap/schema/kerberos.schema.gz
sudo ldap-schema-manager -i /etc/ldap/schema/kerberos.schema

#Create krb5 container
sudo kdb5_ldap_util -D cn=admin,dc=home,dc=com -w password123 -H ldap://auth.home.com create -subtrees dc=home,dc=com -P password123 -r HOME.COM -s 

#Add content
sudo ldapadd -Q -Y EXTERNAL -H ldapi:/// -f add_content.ldif -c
#sudo ldapadd -x -D cn=admin,dc=home,dc=com -w password123 -H ldap://auth.home.com -f add_content.ldif -c

#apply ldif for krb5
sudo ldapmodify -Q -Y EXTERNAL -H ldapi:/// -f krb5Index.ldif -c
sudo ldapadd -Q -Y EXTERNAL -H ldapi:/// -f krb5admin.ldif -c
sudo ldapadd -Q -Y EXTERNAL -H ldapi:/// -f krb5perms.ldif -c

sudo ldapsearch -Y EXTERNAL -H ldapi:/// -b dc=home,dc=com
slapcat -v -b dc=home,dc=com -l out.ldif

#sudo kdb5_ldap_util -D uid=admin,dc=auth,dc=home,dc=com -w password123 stashsrvpw uid=kdc-service,dc=auth,dc=home,dc=com

#dn: cn={4}kerberos,cn=schema,cn=config
# cn=kerberos,cn=schema,cn=config
# cn=krbContainer,dc=home,dc=com
#sudo ldapadd -x -D cn=admin,dc=home,dc=com -w password123 -H ldap://auth.home.com -f krb5admin.ldif -c
#sudo ldapadd -x -D cn=admin,dc=home,dc=com -w password123 -H ldap://auth.home.com -f krb5perms.ldif -c
#sudo ldapsearch -Y EXTERNAL -H ldapi:/// -b cn=kerberos,cn=schema,cn=config
#sudo ldapsearch -Y EXTERNAL -H ldapi:/// -b dc=auth,dc=home,dc=com
#sudo kdb5_ldap_util -D uid=admin,dc=auth,dc=home,dc=com -w password123 stashsrvpw uid=kdc-service,dc=auth,dc=home,dc=com
#sudo kdb5_ldap_util -D cn=admin,dc=home,dc=com -w password123 -H ldap://auth.home.com create -subtrees dc=home,dc=com -P password123 -r HOME.COM -s
