shopt -s nullglob # Sets nullglob
shopt -s nocaseglob # Sets nocaseglob

CURRENTDATE=`date +"%Y-%m-%d %T"`

mkdir "./backup-${CURRENTDATE}"

for image_file in *.{pptx}
do
	echo cp "${image_file}" "./backup-${CURRENTDATE}"
	cp "${image_file}" "./backup-${CURRENTDATE}"

	echo soffice --headless --convert-to pdf "${image_file}"
	soffice --headless --convert-to pdf "${image_file}"
done

shopt -u nocaseglob # Unsets nocaseglob
shopt -u nullglob # Unsets nullglob

