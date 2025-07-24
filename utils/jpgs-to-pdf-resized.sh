CURRENTDATE=`date +"%Y-%m-%d %T"`

echo convert -resize 1024X768 "*.jpg" "${CURRENTDATE}.pdf"

convert -resize 1024X768 "*.jpg" "${CURRENTDATE}.pdf"

