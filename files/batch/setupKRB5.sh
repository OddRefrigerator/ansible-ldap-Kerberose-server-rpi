#!/bin/bash
./setupHost.sh
DEBIAN_FRONTEND=noninteractive apt install -y krb5-{kdc,admin-server,config,user,kdc-ldap} libsasl2-{dev,modules-gssapi-mit,modules} libpam-krb5 sssd-krb5
./copyKRB5ConfigFiles.sh
#CHANGE THIS--> realm and password should be dynamically set from ENV variable or prog switch
kdb5_util create -s -r home.local -P password123
systemctl restart krb5-kdc && sudo systemctl restart krb5-admin-server

