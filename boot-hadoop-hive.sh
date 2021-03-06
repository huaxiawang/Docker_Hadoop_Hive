#!/bin/bash -e
: ${HADOOP_PREFIX:=/usr/local/hadoop}
: ${HIVE_HOME:=/usr/local/hive}
$HADOOP_PREFIX/etc/hadoop/hadoop-env.sh

sed s/HOSTNAME/$HOSTNAME/ /usr/local/hadoop/etc/hadoop/core-site.xml.template > /usr/local/hadoop/etc/hadoop/core-site.xml

service ssh start

cd $HADOOP_PREFIX

sbin/start-dfs.sh
sbin/start-yarn.sh

cd $HIVE_HOME
bin/hiveserver2

if [[ $1 == "-d" ]]; then
  while true; do sleep 1000; done
fi

if [[ $1 == "-bash" ]]; then
  /bin/bash
fi