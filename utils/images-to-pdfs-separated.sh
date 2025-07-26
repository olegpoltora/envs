#CURRENTDATE=`date +"%Y-%m-%d %T"`

#echo convert "$1/*.jpg" "$1/${CURRENTDATE}.pdf"
#echo convert "*.jpg" "${CURRENTDATE}.pdf"

shopt -s nullglob # Sets nullglob
shopt -s nocaseglob # Sets nocaseglob

for image_file in *.{jpg,png}
do
echo convert $image_file "$image_file.pdf"
done

#enable convert to pdf
#sudo sed -i 's/rights="none" pattern="PDF"/rights="read|write" pattern="PDF"/g' /etc/ImageMagick-6/policy.xml

#convert "$1/*.jpg" "$1/${CURRENTDATE}.pdf"
#convert "*.jpg" "${CURRENTDATE}.pdf"

for image_file in *.{jpg,png}
do
convert $image_file "$image_file.pdf"
done

#sudo sed -i 's/rights="read|write" pattern="PDF"/rights="none" pattern="PDF"/g' /etc/ImageMagick-6/policy.xml


shopt -u nocaseglob # Unsets nocaseglob
shopt -u nullglob # Unsets nullglob
