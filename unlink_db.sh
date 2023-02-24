for n in {1..20}; do
  sfolder="/os_root/repo3/docker/volumes/gpdb6_db_seg_$n"
  unlink "$sfolder"
done

