mkdir -p /ddump/gpdb/gpdb6
mv "/repo3/docker/volumes/gpdb6_db_master_1" "/ddump/gpdb/gpdb6/gpdb6_db_master_1"
ln -s "/ddump/gpdb/gpdb6/gpdb6_db_master_1" "/repo3/docker/volumes/gpdb6_db_master_1" 
for n in {1..20}; do  
  sfolder="/repo3/docker/volumes/gpdb6_db_seg_$n"
  dfolder="/ddump/gpdb/gpdb6/gpdb6_db_seg_$n" 
#  echo "mv" "$sfolder" "$dfolder"
#  echo "ln -s" "$dfolder" "$sfolder"
  mv "$sfolder" "$dfolder"
  ln -s "$dfolder" "$sfolder"
done
