#!/bin/bash
set timeout 300
    spawn kdb5_ldap_util stashsrvpw -f /etc/krb5kdc/ldapservice.keyfile uid=kdc-service,{{ ldapBaseDN }}

    expect 'Password for "uid=kdc-service,{{ ldapBaseDN }}":'
    send "{{ ldapkdcpw }}\n"

    exit 0
