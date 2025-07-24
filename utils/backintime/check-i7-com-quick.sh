echo "terra"
ls -la "/media/poltora/Terra/.backup/backintime/poltora-i7-com/poltora/4/last_snapshot/backup/mnt/poltora/1.5/" | grep 1.5.grsync
#ls -la "/media/poltora/Terra/.backup/backintime/poltora-i7-com/poltora/4/20200105-013120-272/backup/mnt/poltora/1.5/" | grep 1.5.grsync
echo ""


echo "terra priv"
encfs /media/poltora/Terra/.i7-com-priv /media/poltora/Terra/.i7-com

ls -la "/media/poltora/Terra/.i7-com/backintime/poltora-i7-com/poltora/5/last_snapshot/backup/mnt/poltora/.priv/1.5/" | grep 1.5.priv.grsync
#ls -la "/media/poltora/Terra/.i7-com/backintime/poltora-i7-com/poltora/5/20191229-211937-113/backup/mnt/poltora/.priv/1.5/" | grep 1.5.priv.grsync
echo ""


fusermount -u /media/poltora/Terra/.i7-com




