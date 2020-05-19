#!/bin/bash
krb5_newrealm
#kdb5_util create -s -r home.com -P password123
kadmin.local -q "ktadd -k /etc/krb5kdc/kadm5.keytab kadmin/admin"
kadmin.local -q "ktadd -k /etc/krb5kdc/kadm5.keytab kadmin/changepw"
kadmin.local -q "ktadd -k /etc/krb5kdc/kadm5.keytab krbtgt/HOME.COM"
