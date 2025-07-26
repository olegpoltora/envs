#DIRS="$(dirname "$(readlink -f "$0")")"
#obj=$1
#meld /mnt/poltora/Soft/configs/install-env-dev.sh /run/user/1000/gvfs/ftp\:host\=192.168.100.50\,user\=poltora/mnt/poltora/Soft/configs/install-env-dev.sh

#WORK_ENV="/run/user/1000/gvfs/ftp\:host\=192.168.100.50\,user\=poltora"

WORK_ENV="poltora:paranoyafobiya@ftp://192.168.100.249"

location="$(pwd)"
file=$1

one=${location}/${file}
second=${WORK_ENV}${location}/${file}


#echo $location
#echo $file

#echo $one
#echo $second


echo vimdiff ${one} "${second}"
eval vimdiff "${one}" "${second}"