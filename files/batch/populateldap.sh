#!/bin/bash
sudo ldapmodify -Q -Y EXTERNAL -H ldapi:/// -f logging.ldif

sudo cp /usr/share/doc/krb5-kdc-ldap/kerberos.schema.gz /etc/ldap/schema/
sudo gunzip /etc/ldap/schema/kerberos.schema.gz
sudo ldap-schema-manager -i /etc/ldap/schema/kerberos.schema

#apply ldif for krb5
sudo ldapmodify -Q -Y EXTERNAL -H ldapi:/// -f addkrb5Index.ldif -c
sudo ldapadd -Q -Y EXTERNAL -H ldapi:/// -f krb5admin.ldif -c
sudo ldapadd -Q -Y EXTERNAL -H ldapi:/// -f krb5perms.ldif -c

sudo kdb5_ldap_util -D uid=admin,dc=auth,dc=home,dc=com -w password123 stashsrvpw -f /etc/krb5kdc/service.keyfile uid=kdc-service,dc=auth,dc=home,dc=com

ldapadd -x -D cn=admin,dc=auth,dc=home,dc=com -W -f add_content.ldif -c
ldapsearch -x -LLL -H ldap:/// -b dc=home,dc=com
slapcat -v -b dc=home,dc=com -l out.ldif
