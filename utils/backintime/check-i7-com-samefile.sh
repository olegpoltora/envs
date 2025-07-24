echo "terra"
find \
/media/poltora/Terra/.backup/backintime/poltora-i7-com/poltora/4/ \
-samefile \
"/media/poltora/Terra/.backup/backintime/poltora-i7-com/poltora/4/last_snapshot/backup/mnt/poltora/1.5/1.5.grsync"


echo "terra priv"
encfs /media/poltora/Terra/.i7-com-priv /media/poltora/Terra/.i7-com

find \
/media/poltora/Terra/.i7-com/backintime/poltora-i7-com/poltora/5/ \
-samefile \
"/media/poltora/Terra/.i7-com/backintime/poltora-i7-com/poltora/5/last_snapshot/backup/mnt/poltora/.priv/1.5/1.5.priv.grsync"

fusermount -u /media/poltora/Terra/.i7-com


