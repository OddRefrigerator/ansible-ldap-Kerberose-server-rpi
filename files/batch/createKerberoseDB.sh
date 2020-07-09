#!/bin/bash
#krb5_newrealm
#kdb5_util create -s -r HOME.COM -P password123
kadmin.local -q "ktadd -k /etc/krb5kdc/kadm5.keytab kadmin/admin"
kadmin.local -q "ktadd -k /etc/krb5kdc/kadm5.keytab kadmin/changepw"
kadmin.local -q "ktadd -k /etc/krb5kdc/kadm5.keytab krbtgt/HOME.COM"

#kdb5_util create -s -r HOME.COM -P password123
#kdb5_ldap_util -D cn=admin,dc=auth,dc=home,dc=com create -subtrees dc=home,dc=com -r HOME.COM -s -H ldapi:///


