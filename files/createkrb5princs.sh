#!/bin/bash
kadmin.local -q "addprinc -randkey host/kdc.home.com"
kadmin.local -q "addprinc -randkey ldap/kdc.home.com@HOME.COM"
kadmin.local -q "ktadd host/kdc.home.com@HOME.COM"
kadmin.local -q "ktadd ldap/kdc.home.com@HOME.COM"
