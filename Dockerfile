FROM java:7
MAINTAINER hwang <hwang@transcendinsight.com>

RUN wget http://mirror.tcpdiag.net/apache/hadoop/common/hadoop-2.6.0/hadoop-2.6.0.tar.gz
RUN mkdir /hadoop-dist
RUN mv hadoop-2.6.0.tar.gz /hadoop-dist
RUN cd /hadoop-dist/ && tar zxf hadoop-2.6.0.tar.gz && rm hadoop-2.6.0.tar.gz

RUN ssh-keygen -t dsa -P '' -f ~/.ssh/id_dsa
RUN cat ~/.ssh/id_dsa.pub >> ~/.ssh/authorized_keys
RUN ssh-keyscan -H localhost >> /root/.ssh/known_hosts
RUN ssh-keyscan -H 127.0.0.1 >> ~/.ssh/known_hosts
RUN ssh-keyscan -H 0.0.0.0 >> ~/.ssh/known_hosts

ENV JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64
ENV HADOOP_HOME=/hadoop-dist/hadoop-2.6.0
ENV HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop

ADD *.xml $HADOOP_CONF_DIR/
ADD slaves $HADOOP_CONF_DIR/
ADD hadoop-env.sh $HADOOP_CONF_DIR/
ADD boot-hadoop.sh /
RUN chmod 777 /boot-hadoop.sh
RUN mkdir /var/tmp/hadoop && mkdir /var/tmp/pid

VOLUME ["/var/tmp/hadoop", "/var/tmp/pid"]

# SSH
EXPOSE 22

# HDFS

# dfs.http.address
EXPOSE 50070

# fs.default.name
EXPOSE 9000

# dfs.datanode.http.address
EXPOSE 50075

# dfs.datanode.address
EXPOSE 50010

# dfs.datanode.ipc.address
EXPOSE 50020

# dfs.secondary.http.address
EXPOSE 50090

#YARN

# yarn.resourcemanager.scheduler.address
EXPOSE 8030

# yarn.resourcemanager.resource-tracker.address
EXPOSE 8031

# yarn.resourcemanager.address
EXPOSE 8032

# yarn.resourcemanager.admin.address
EXPOSE 8033

# yarn.nodemanager.localizer.address
EXPOSE 8040

# yarn.nodemanager.webapp.address
EXPOSE 8042

# yarn.resourcemanager.webapp.address
EXPOSE 8088

CMD /boot-hadoop.sh