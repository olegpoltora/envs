#DIRS="$(dirname "$(readlink -f "$0")")"
#obj=$1
#meld /mnt/poltora/Soft/configs/install-env-dev.sh /run/user/1000/gvfs/ftp\:host\=192.168.100.50\,user\=poltora/mnt/poltora/Soft/configs/install-env-dev.sh

#WORK_ENV="/run/user/1000/gvfs/ftp\:host\=192.168.100.50\,user\=poltora"
#WORK_ENV="poltora:paranoyafobiya@ftp://192.168.100.249"
WORK_ENV=~/ftp_mount

location="$(pwd)"
#echo $location

# Использование встроенных (gio mount) позволяет переместиться в /mnt/poltora
# Залогинится с поммощью ftp ftp:// и затем сменить католаг - можно.
# Но при использовании curlftpfs, внешний vsftpd (ftp сервер) не позволяет указать каталог /mnt/poltora - Server denied you to change to the given directory
# Решение - симлинк в домашний каталог на сервере.
# НЕТ, не решение - симлинк работает для домашней системы и ведет в домшний каталог!

locationRemote=${location/\/mnt/}
#echo $locationRemote

file=$1
file=${file/\.\//}
#echo $file


#-o allow_other
echo curlftpfs ftp://poltora:paranoyafobiya@192.168.100.249 $WORK_ENV 
curlftpfs ftp://poltora:paranoyafobiya@192.168.100.249 $WORK_ENV
#echo curlftpfs ftp://poltora:paranoyafobiya@192.168.100.249${locationRemote} $WORK_ENV -o allow_other
#curlftpfs ftp://poltora:paranoyafobiya@192.168.100.249${locationRemote} $WORK_ENV -o allow_other

one=${location}/${file}
#echo $one

second=${WORK_ENV}${locationRemote}/${file}
#echo $second

echo meld ${one} "${second}"
eval meld "${one}" "${second}"

fusermount -u ~/ftp_mount
