#!/bin/bash
kadmin.local -q "addprinc -randkey host/kdc.home.com"
kadmin.local -q "addprinc -randkey host/192.168.1.10@HOME.COM"
kadmin.local -q "addprinc -randkey ldap/kdc.home.com@HOME.COM"
kadmin.local -q "addprinc -randkey ldap/192.168.1.10@HOME.COM"
kadmin.local -q "addprinc -randkey nfs/kdc.home.com@HOME.COM"
kadmin.local -q "addprinc -randkey nfs/192.168.1.10@HOME.COM"
kadmin.local -q "ktadd -k /etc/krb5.keytab host/kdc.home.com@HOME.COM"
kadmin.local -q "ktadd -k /etc/krb5.keytab ldap/kdc.home.com@HOME.COM"
kadmin.local -q "ktadd -k /etc/krb5.keytab ldap/192.168.1.10@HOME.COM"
kadmin.local -q "ktadd -k /etc/krb5.keytab nfs/192.168.1.10@HOME.COM"
kadmin.local -q "ktadd -k /etc/krb5.keytab nfs/kdc.home.com@HOME.COM"
