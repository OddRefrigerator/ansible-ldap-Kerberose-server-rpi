#!/bin/bash
sudo hostnamectl set-hostname auth.home.com
sudo timedatectl set-timezone America/Toronto
sudo apt update 
sudo apt upgrade -y
export ldapPassword="password123"
export slapAdmin="password123"
export realm="HOME.COM"
