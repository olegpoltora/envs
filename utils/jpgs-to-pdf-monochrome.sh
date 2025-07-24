CURRENTDATE=`date +"%Y-%m-%d %T"`

echo convert "*.jpg" -monochrome -compress lzw "${CURRENTDATE}.pdf"

convert "*.jpg" -monochrome -compress lzw "${CURRENTDATE}.pdf"

