#!/bin/bash
ldapmodify -Q -Y EXTERNAL -H ldapi:/// -f logging.ldif
cd /usr/share/doc/krb5-kdc-ldap
gunzip /usr/share/doc/krb5-kdc-ldap/kerberos.openldap.ldif.gz
ldap-schema-manager -i /usr/share/doc/krb5-kdc-ldap/kerberos.schema
ldapadd -x -D cn=admin,dc=home,dc=com -W -f krb5admin.ldif -c
ldappasswd -x -D cn=admin,dc=home,dc=com -s password123 uid=kdc-service,dc=home,dc=com -w password123
ldappasswd -x -D cn=admin,dc=home,dc=com -s password123 uid=kadmin-service,dc=home,dc=com -w password123
kdb5_ldap_util -D cn=admin,dc=home,dc=com stashsrvpw -f /etc/krb5kdc/service.keyfile uid=kdc-service,dc=home,dc=com
kdb5_ldap_util -D cn=admin,dc=home,dc=com stashsrvpw -f /etc/krb5kdc/service.keyfile uid=kadmin-service,dc=home,dc=com
ldapadd -x -D cn=admin,dc=home,dc=com -W -f add_content.ldif -c
ldapsearch -x -LLL -H ldap:/// -b dc=home,dc=com
slapcat -v -b dc=home,dc=com -l out.ldif
