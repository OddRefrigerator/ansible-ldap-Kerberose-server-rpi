#!/bin/bash
ldapadd -x -D cn=admin,dc=home,dc=local -W <<EOF
dn: uid=kdc-service,dc=home,dc=local
uid: kdc-service
objectClass: account
objectClass: simpleSecurityObject
userPassword: {CRYPT}x
description: Account used for the Kerberos KDC

dn: uid=kadmin-service,dc=home,dc=local
uid: kadmin-service
objectClass: account
objectClass: simpleSecurityObject
userPassword: {CRYPT}x
description: Account used for the Kerberos Admin server
EOF
