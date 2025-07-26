BACKINTIME="/mnt/backup/.priv/backintime"
PROFILE="/my/poltora/2"
BACKED="/mnt/poltora"

echo "${BACKINTIME}${PROFILE}/$1/backup${BACKED}/"
#ls -la "${BACKINTIME}${PROFILE}/$1/backup${BACKED}/"

echo "VS"
echo "${BACKINTIME}${PROFILE}/$2/backup${BACKED}/"
#ls -la "${BACKINTIME}${PROFILE}/$2/backup${BACKED}/"

echo ""
diff --brief --recursive "${BACKINTIME}${PROFILE}/$1/backup${BACKED}/" "${BACKINTIME}${PROFILE}/$2/backup${BACKED}/" 

#echo ""
#diff --brief --recursive "${BACKINTIME}${PROFILE}/$1/backup${BACKED}/" "${BACKINTIME}${PROFILE}/$2/backup${BACKED}/" \
# | grep "Only in ${BACKINTIME}${PROFILE}/$2" \
# | sed  "s;Only in ${BACKINTIME}${PROFILE}/$2/backup${BACKED};;g"


#echo "NEW in $2"