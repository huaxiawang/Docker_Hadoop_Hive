#!/bin/bash -e

cd $HADOOP_HOME

if [ ! -d "/var/tmp/hadoop/dfs" ]; then
	bin/hdfs namenode -format
fi

sbin/start-dfs.sh

bin/hdfs dfs -mkdir /user
bin/hdfs dfs -mkdir /user/hwang
bin/hdfs dfs -mkdir /user/hwang/log

bin/hdfs dfs -mkdir /tmp
bin/hdfs dfs -mkdir /user/hive
bin/hdfs dfs -mkdir /user/hive/warehouse
bin hdfs dfs -chmod g+w /tmp
bin hdfs dfs -chmod g+w /user/hive/warehouse

sbin/start-yarn.sh