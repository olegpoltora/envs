#CURRENTDATE=`date +"%Y-%m-%d %T"`

#mkdir "./backup-${CURRENTDATE}"

for image_file in *.webp
do
#	echo cp $image_file "./backup-${CURRENTDATE}"
#	cp $image_file "./backup-${CURRENTDATE}"

	#echo convert -trim $image_file "${image_file%%.*}-trimed.${image_file##*.}"
	#convert -trim $image_file "${image_file%%.*}-trimed.${image_file##*.}"

	echo convert $image_file ${image_file}.png
	convert $image_file ${image_file}.png
	
#	rm $image_file
done
