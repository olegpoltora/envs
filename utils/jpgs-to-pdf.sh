CURRENTDATE=`date +"%Y-%m-%d %T"`

echo convert "*.jpg" "${CURRENTDATE}.pdf"

convert "*.jpg" "${CURRENTDATE}.pdf"

