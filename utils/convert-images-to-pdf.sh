for image_file in *.{jpg,png,webp}
do
    echo convert $image_file "$image_file.pdf"
    convert $image_file "$image_file.pdf"
done
