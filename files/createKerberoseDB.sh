#!/bin/bash
sudo kdb5_util create -s -r HOME.LOCAL -P kDBpassword
sudo kadmin.local -q "ktadd -k /etc/krb5kdc/kadm5.keytab kadmin/admin"
sudo kadmin.local -q "ktadd -k /etc/krb5kdc/kadm5.keytab kadmin/changepw"
