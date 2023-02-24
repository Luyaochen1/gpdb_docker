rebuild / recreate docker images with multihost including the new node

check ../data/gpmaster/gpsne-1/pg_hba.conf for trust connection >> for all databases and all nodes ( can do seg_1 only)

cat newhost
db_seg_3

cat hostlist
db_seg_1
db_seg_2


source /usr/local/greenplum-db/greenplum_path.sh

gpssh-exkeys -e hostlist -x newhost

run gpexpand with new host

cat gpexpand_inputfile_20230224_185735
db_seg_3|db_seg_3|20000|/var/lib/gpdb/data/gpdata1/gpsne4|6|4|p
db_seg_3|db_seg_3|20001|/var/lib/gpdb/data/gpdata2/gpsne5|7|5|p

gpexpand -i gpexpand_inputfile_20230224_185735

