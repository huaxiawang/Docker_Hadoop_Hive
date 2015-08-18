#!/bin/bash -e
: ${HADOOP_PREFIX:=/usr/local/hadoop}
$HADOOP_PREFIX/etc/hadoop/hadoop-env.sh

sed s/HOSTNAME/$HOSTNAME/ /usr/local/hadoop/etc/hadoop/core-site.xml.template > /usr/local/hadoop/etc/hadoop/core-site.xml

service ssh start

cd $HADOOP_PREFIX
# if [ ! -d "/var/tmp/hadoop/dfs" ]; then
# 	bin/hdfs namenode -format
# fi
sbin/start-dfs.sh
sbin/start-yarn.sh

bin/hdfs dfs -mkdir /user
bin/hdfs dfs -mkdir /user/hwang
bin/hdfs dfs -mkdir /user/hwang/log

bin/hdfs dfs -mkdir /tmp
bin/hdfs dfs -mkdir /user/hive
bin/hdfs dfs -mkdir /user/hive/warehouse
bin hdfs dfs -chmod g+w /tmp
bin hdfs dfs -chmod g+w /user/hive/warehouse

if [[ $1 == "-d" ]]; then
  while true; do sleep 1000; done
fi

if [[ $1 == "-bash" ]]; then
  /bin/bash
fi