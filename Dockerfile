#FROM ubuntu:16.04
#
#RUN apt-get update && apt-get install -y openssh-server \
#    && apt-get install -y software-properties-common \
#    && add-apt-repository -y ppa:greenplum/db \
#    && apt-get update && apt-get install -y greenplum-db-oss \
#    && apt-get install -y less vim sudo

# FROM centos:7
# FROM nvidia/cuda:10.1-base-centos7
# FROM  nvidia/cuda:11.0.3-base-centos8
# FROM nvidia/cuda:11.1.1-base-centos8
FROM gpdb-cuda_11.1.1-base-centos8-py3.9

# RUN ln -sf /usr/local/bin/python3.9 /usr/bin/python

ENV install_path /usr/local/greenplum-db


# set locale
#RUN localedef -v -c -i en_US -f UTF-8 en_US.UTF-8 --quiet
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8 

WORKDIR /var/lib/gpdb/setup/

#REPLACE WITH "ADD hostlist ." to specify segment nodes
ADD multihost .
ADD singlehost .
ADD gpinitsys .
RUN chown -R gpadmin:gpadmin /var/lib/gpdb

ENV USER=gpadmin
ENV MASTER_DATA_DIRECTORY=/var/lib/gpdb/data/gpmaster/gpsne-1

# add the entrypoint script
ADD docker-entrypoint.sh /usr/local/bin/
ADD monitor_master.sh   .
RUN chmod 755 /usr/local/bin/docker-entrypoint.sh
# add monitor script
RUN chmod +x monitor_master.sh
RUN chown -R gpadmin:gpadmin /var/lib/gpdb

#sshd must exist for gpdb monitor_master.sh
RUN echo 'gpadmin ALL=(ALL) NOPASSWD:/usr/sbin/sshd' >> /etc/sudoers


USER gpadmin

ENV GPHOME=/usr/local/greenplum-db
ENV PATH=$GPHOME/bin:$PATH
ENV PYTHONPATH=$GPHOME/lib/python
ENV LD_LIBRARY_PATH=$GPHOME/lib:$LD_LIBRARY_PATH
ENV OPENSSL_CONF=$GPHOME/etc/openssl.cnf
ENV GP_NODE=master
ENV HOSTFILE=singlehost
####CHANGE THIS TO YOUR LOCAL SUBNET

VOLUME /var/lib/gpdb/
ENTRYPOINT ["docker-entrypoint.sh"]
EXPOSE 5432

CMD ["./monitor_master.sh"]
