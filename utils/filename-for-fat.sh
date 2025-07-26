#-n - dry
#find . -exec rename  -n 's/[?<>\\:*|\"]/_/g' "{}" \;

#find . -exec rename 's/[?<>\\:*|\"]/_/g' "{}" \;
#find . -exec mv 's/[?<>\\:*|\"]/_/g' "{}" \;


for i in .; do
    find $i -name '*.txt'; 
done

#s/[?<>\\:*|\"]/
# -exec mv {} dir2/`basename $i`.txt \;
