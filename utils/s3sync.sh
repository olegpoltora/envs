#--delete-removed \
#--no-preserve \
#--storage-class STANDARD_IA

s3cmd \
--no-follow-symlinks \
sync "./$1" "s3://backup.poltora/$1"
