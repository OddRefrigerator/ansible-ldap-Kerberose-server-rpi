#!/bin/bash
ldapmodify -Q -Y EXTERNAL -H ldapi:/// -f logging.ldif
ldapadd -x -D cn=admin,dc=home,dc=com -W -f add_content.ldif
ldapsearch -x -LLL -H ldap:/// -b dc=home,dc=com
slapcat -v -b dc=home,dc=com -l out.ldif
