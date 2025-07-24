CURRENTDATE=`date +"%Y-%m-%d %T"`

echo convert "*.jpg" -monochrome -compress lzw "${CURRENTDATE}.tiff"

convert "*.jpg" -monochrome -compress lzw "${CURRENTDATE}.tiff"

