find . -type f -exec rename 's/\|/\-/g' '{}' \;
find . -type f -exec rename 's/\:/\-/g' '{}' \;
find . -type f -exec rename 's/\//\-/g' '{}' \;
find . -type f -exec rename 's/\*/\-/g' '{}' \;
find . -type f -exec rename 's/\+/\-/g' '{}' \;
