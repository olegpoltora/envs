SIZE=$1
if [[ $SIZE == '' ]] 
then
	echo "use default size as 1920x1080"
	SIZE="1920x1080"
fi

read -p "Monochrome? (y/N)?" isMonochrome
if [[ $isMonochrome != '' ]] 
then
	echo "use monochrome and compress"
	isMonochrome="-monochrome -compress lzw"
fi

CURRENTDATE=`date +"%Y-%m-%d %T"`

echo convert -resize $SIZE $isMonochrome "*.{jpg,png,webp}" "${CURRENTDATE}.pdf"
convert -resize $SIZE $isMonochrome *.{jpg,png,webp} "${CURRENTDATE}.pdf"

