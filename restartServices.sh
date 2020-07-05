#!/bin/bash
systemctl restart krb5-kdc
systemctl restart krb5-admin-server
systemctl restart slapd