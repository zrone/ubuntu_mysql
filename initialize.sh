#!/bin/bash

apt-get update
apt-get install expect -y
apt-get install cmake -y
apt-get install libncurses5-dev -y
apt-get install build-essential -y
apt-get install libfontconfig1 -y
apt-get install mesa-common-dev -y
apt-get install libglu1-mesa-dev -y
mkdir /server
cd /home/mysql_boost-5.7.9/mysql-5.7.9
cmake ./ \
-DCMAKE_INSTALL_PREFIX=/server/mysql \
-DWITH_BOOST=./boost_1_59_0.tar.gz \
-DMYSQL_DATADIR=/server/mysql/data \
-DSYSCONFDIR=/server/mysql/etc \
-DWITH_MYISAM_STORAGE_ENGINE=1 \
-DWITH_INNOBASE_STORAGE_ENGINE=1 \
-DWITH_MEMORY_STORAGE_ENGINE=1 \
-DWITH_READLINE=1 \
-DMYSQL_UNIX_ADDR=/tmp/mysqld.sock \
-DMYSQL_TCP_PORT=3306 \
-DENABLED_LOCAL_INFILE=1 \
-DWITH_PARTITION_STORAGE_ENGINE=1 \
-DEXTRA_CHARSETS=all \
-DDEFAULT_CHARSET=utf8mb4 \
-DDEFAULT_COLLATION=utf8_general_ci;
make
make install
groupadd mysql
useradd -g mysql mysql
mkdir /server/mysql/etc
cp /home/my.cnf /server/mysql/etc/my.cnf

# 初始化
/server/mysql/bin/mysqld --initialize-insecure --user=mysql

# 启动mysql服务
/server/mysql/support-files/mysql.server start

# 修改mysql初始密码
expect -c "
spawn /server/mysql/bin/mysqladmin -uroot -p password \"hzlanxin#passwd@20160519\"
expect \"Enter password:\"
send \"\r\"
interact
"