#!/bin/bash
sudo /usr/sbin/sshd

m="master"
if [ "$GP_NODE" == "$m" ]

then
     echo 'Node type='$GP_NODE
    if [ ! -d $MASTER_DATA_DIRECTORY ]; then
        echo 'Master directory does not exist. Initializing master from gpinitsystem_reflect.'
        yes | cp $HOSTFILE hostlist
        gpssh-exkeys -f hostlist
        echo "Key exchange complete"
        gpinitsystem -a  -c gpinitsys --su_password=gpadmin1
#        gpinitsystem -a  -c gpinitsys -m 250 -b 125MB --su_password=gpadmin1
        echo "Master node initialized"
        # receive connection from anywhere.. This should be changed!!
        echo "host all all 0.0.0.0/0 md5" >>/var/lib/gpdb/data/gpmaster/gpsne-1/pg_hba.conf
        gpstop -u
    else
        echo 'Master exists. Restarting gpdb.'
        gpstart -a
    fi
else
    echo 'Node type='$GP_NODE
fi
exec "$@"
