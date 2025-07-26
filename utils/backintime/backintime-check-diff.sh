FROM=$1
shift
TO=$1
shift

LOCATION=$1
if [[ $LOCATION == '' ]] 
then
	echo "use default backup location"
	LOCATION="/mnt/backup"
fi

BACKINTIME=${LOCATION}"/backintime"
PROFILE="/my/poltora/1"
BACKED="/mnt/poltora"

echo "${BACKINTIME}${PROFILE}/$FROM/backup${BACKED}/"
#ls -la "${BACKINTIME}${PROFILE}/$FROM/backup${BACKED}/"

echo "VS"
echo "${BACKINTIME}${PROFILE}/$TO/backup${BACKED}/"
#ls -la "${BACKINTIME}${PROFILE}/$TO/backup${BACKED}/"

echo ""
diff --brief --recursive "${BACKINTIME}${PROFILE}/$FROM/backup${BACKED}/" "${BACKINTIME}${PROFILE}/$TO/backup${BACKED}/" 

echo ""
#diff --brief --recursive "${BACKINTIME}${PROFILE}/$FROM/backup${BACKED}/" "${BACKINTIME}${PROFILE}/$TO/backup${BACKED}/" \
# | grep "Only in ${BACKINTIME}${PROFILE}/$TO" \
# | sed  "s;Only in ${BACKINTIME}${PROFILE}/$TO/backup${BACKED};;g"


#echo "NEW in $TO"