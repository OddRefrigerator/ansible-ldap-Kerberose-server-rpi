#!/bin/bash
export REALM="HOME.COM"
export krb5DBpw="password123"
export krb5admpw="password123"
export krb5kdcldap="password123"
export krb5adminldap="password123"

apt install -y krb5-{kdc,admin-server,config,user,kdc-ldap} libsasl2-{dev,modules-gssapi-mit,modules} libpam-krb5 sssd-krb5 
systemctl stop krb5-kdc
systemctl stop krb5-admin-server

cp ../conf/kadm5.acl /etc/krb5kdc/kadm5.acl
cp ../conf/krb5.conf /etc/krb5.conf
cp ../conf/kdc.conf /etc/krb5kdc/kdc.conf

{ echo '$krb5DBpw\n'; echo '$krb5DBpw\n';} | sudo kdb5_util create -s -r $REALM

systemctl start krb5-kdc
systemctl start krb5-admin-server

