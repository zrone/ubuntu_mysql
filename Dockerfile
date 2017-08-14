FROM hub.c.163.com/public/ubuntu:16.04-tools
MAINTAINER zrone <xujining2008@126.com>

# 私有库文件包
ADD http://101.37.20.21:16500/mysql_boost-5.7.9.tar.gz /home/mysql_boost-5.7.9

COPY my.cnf /home/my.cnf

# 初始化mysql服务
ADD initialize.sh /home/initialize.sh

RUN sh /home/initialize.sh

# 导出端口
EXPOSE 3306
EXPOSE 22