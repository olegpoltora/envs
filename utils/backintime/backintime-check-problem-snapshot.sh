BACKINTIME="/mnt/backup/backintime"
PROFILE="/my/poltora/1"
BACKED="/mnt/poltora"

echo "${BACKINTIME}${PROFILE}/$1/backup${BACKED}/"
#ls -la "${BACKINTIME}${PROFILE}/$1/backup${BACKED}/"
echo "VS"
echo ${BACKED}

#echo "Absent in $1"
#diff --brief --recursive --exclude='.priv' --exclude='.priv.sec' --exclude='.Trash-1000' --exclude='lost+found' --exclude='Альбомы.Temp' "${BACKINTIME}${PROFILE}/$1/backup${BACKED}/" "${BACKED}/" 
#diff --brief --recursive -exclude-from=backintime-check-problem-snapshot-exclude-file.txt "${BACKINTIME}${PROFILE}/$1/backup${BACKED}/" "${BACKED}/" 

diff --brief --recursive --no-dereference "${BACKINTIME}${PROFILE}/$1/backup${BACKED}/" "${BACKED}/" 



#echo "Absent in $1"
#diff --brief --recursive "${BACKINTIME}${PROFILE}/$1/backup${BACKED}/" "${BACKED}/" \
# | grep "Only in ${BACKINTIME}${PROFILE}/$2" \
# | sed  "s;Only in ${BACKINTIME}${PROFILE}/$2/backup${BACKED};;g"

