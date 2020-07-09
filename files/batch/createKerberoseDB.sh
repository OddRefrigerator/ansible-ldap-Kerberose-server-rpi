#!/bin/bash
#krb5_newrealm
#kdb5_util create -s -r home.local -P password123
kadmin.local -q "ktadd -k /etc/krb5kdc/kadm5.keytab kadmin/admin"
kadmin.local -q "ktadd -k /etc/krb5kdc/kadm5.keytab kadmin/changepw"
kadmin.local -q "ktadd -k /etc/krb5kdc/kadm5.keytab krbtgt/home.local"

#kdb5_util create -s -r home.local -P password123
#kdb5_ldap_util -D cn=admin,dc=auth,dc=home,dc=local create -subtrees dc=home,dc=local -r home.local -s -H ldapi:///


