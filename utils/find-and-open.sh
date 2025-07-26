#grep -ril "$*" . | tee /dev/tty | xargs -d '\n' -I {} xdg-open "{}"

{
  grep -ril --include='*.*' --exclude='*.pdf' "$*" . ;
  pdfgrep -ril "$*" . ;
} | sort -u | tee /dev/tty | xargs -d '\n' -I {} xdg-open "{}"

#{
#  find . -type f -not -name '*.pdf' -exec grep -ril "$*" {} + ;
#  pdfgrep -ril "$*" . ;
#} | sort -u | tee /dev/tty | xargs -d '\n' -I {} xdg-open "{}"


#pdfgrep -ril "$*" . | tee /dev/tty | xargs -d '\n' -I {} xdg-open "{}"

#grep -ril --include='*.*' --exclude='*.pdf' "$*" | tee /dev/tty | xargs -d '\n' -I {} xdg-open "{}"
