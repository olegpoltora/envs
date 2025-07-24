BACKINTIME_PATH="/media/poltora/Terra/.backup/backintime/i7-com/poltora/4"
BACKED_PATH="backup/mnt/poltora"

echo "$BACKINTIME_PATH/$1/$BACKED_PATH/"
echo "$BACKINTIME_PATH/$2/$BACKED_PATH/"

diff --brief --recursive "$BACKINTIME_PATH/$1/$BACKED_PATH/" "$BACKINTIME_PATH/$2/$BACKED_PATH/" \
 | grep "Only in $BACKINTIME_PATH/$1" \
 | sed  "s;Only in $BACKINTIME_PATH/$1/$BACKED_PATH;;g"


echo "OLD in $1"