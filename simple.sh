#!/bin/bash

wget http://dev.mysql.com/get/mysql-apt-config_0.7.2-1_all.deb
dpkg -i mysql-apt-config_0.7.2-1_all.deb
apt-get update
apt-get install -y mysql-server-5.7