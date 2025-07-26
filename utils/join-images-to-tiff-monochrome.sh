CURRENTDATE=`date +"%Y-%m-%d %T"`

echo convert "*.{jpg,png,webp}" -monochrome -compress lzw "${CURRENTDATE}.tiff"
convert *.{jpg,png,webp} -monochrome -compress lzw "${CURRENTDATE}.tiff"

