#shopt -s nullglob # Sets nullglob
#shopt -s nocaseglob # Sets nocaseglob

SIZE=$1
if [[ $SIZE == '' ]] 
then
	echo "use default size as 1920x1080"
	SIZE="1920x1080"
fi


CURRENTDATE=`date +"%Y-%m-%d %T"`

mkdir "./backup-${CURRENTDATE}"

for image_file in *.{jpg,png,webp}
do
	echo cp $image_file "./backup-${CURRENTDATE}"
	cp $image_file "./backup-${CURRENTDATE}"

	#echo convert -trim $image_file "${image_file%%.*}-trimed.${image_file##*.}"
	#convert -trim $image_file "${image_file%%.*}-trimed.${image_file##*.}"

	echo convert -resize $SIZE $image_file ${image_file}
	convert -resize $SIZE $image_file ${image_file}
done

#sudo sed -i 's/rights="read|write" pattern="PDF"/rights="none" pattern="PDF"/g' /etc/ImageMagick-6/policy.xml


#shopt -u nocaseglob # Unsets nocaseglob
#shopt -u nullglob # Unsets nullglob

