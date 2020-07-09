#!/bin/bash
#give pi krb5 account
kadmin.local -q "addprinc -pw raspberry pi"
kadmin.local -q "addprinc -pw raspberry pi/admin"
kadmin.local -q "addprinc -pw password123 krb5ldap/admin"
#kadmin.local -q "ktadd -k /etc/krb5kdc/kadm5.keytab pi/admin@home.local"
#Services-FQDN
kadmin.local -q "addprinc -randkey host/auth.home.local@home.local"
kadmin.local -q "addprinc -randkey ldap/auth.home.local@home.local"
kadmin.local -q "addprinc -randkey nfs/auth.home.local@home.local"
kadmin.local -q "ktadd -k /etc/krb5kdc/kadm5.keytab host/auth.home.local@home.local"
kadmin.local -q "ktadd -k /etc/krb5kdc/kadm5.keytab ldap/auth.home.local@home.local"
kadmin.local -q "ktadd -k /etc/krb5kdc/kadm5.keytab nfs/auth.home.local@home.local"
#Services-IP
kadmin.local -q "addprinc -randkey host/192.168.1.10@home.local"
kadmin.local -q "addprinc -randkey ldap/192.168.1.10@home.local"
kadmin.local -q "addprinc -randkey nfs/192.168.1.10@home.local"
kadmin.local -q "ktadd -k /etc/krb5kdc/kadm5.keytab host/192.168.1.10@home.local"
kadmin.local -q "ktadd -k /etc/krb5kdc/kadm5.keytab ldap/192.168.1.10@home.local"
kadmin.local -q "ktadd -k /etc/krb5kdc/kadm5.keytab nfs/192.168.1.10@home.local"
#krb5 service accounts
kadmin.local -q "addprinc -randkey kdc-service/admin@home.local"
kadmin.local -q "addprinc -randkey kadmin-service/admin@home.local"
kadmin.local -q "ktadd -k /etc/krb5kdc/kadm5.keytab kdc-service/admin@home.local"
kadmin.local -q "ktadd -k /etc/krb5kdc/kadm5.keytab kadmin-service/admin@home.local"
#Keytab exports testing
#kadmin.local -q "ktadd -k /etc/krb5kdc/kadm5.keytab kadmin/admin"
#kadmin.local -q "ktadd -k /etc/krb5kdc/kadm5.keytab kadmin/changepw"
#kadmin.local -q "ktadd -k /etc/krb5kdc/kadm5.keytab krbtgt/home.local"
