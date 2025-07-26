LOCATION=$1
shift
if [[ $LOCATION == '' ]] 
then
	echo "use default backup location"
	LOCATION="/mnt/backup"
fi
echo location: $LOCATION

profile=$1
shift
if [[ $profile == '' ]] 
then
	echo "use default backup profile"
	profile="my"
fi
echo profile: $profile

BACKINTIME=${LOCATION}"/backintime"
PROFILE="/${profile}/poltora/1"
BACKED="/mnt/poltora"

#du -hc --max-depth=0 ${BACKINTIME}${PROFILE}/*

ls -la "${BACKINTIME}${PROFILE}/last_snapshot/backup/${BACKED}/" | grep .check-file-for-statistic-backintime
