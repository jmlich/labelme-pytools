#!/bin/bash

FIX=/bin/false
imgdir='/home/jmlich/workspace/fire/labelme/LabelMeAnnotationTool/Images'

i=0

while IFS= read -r -d $'\0' img; do

    out=$(identify -format '%[exif:orientation]' "$img" 2>/dev/null)
    rv="$?"

    if [[ "$out" != "" && "$out" -ne 1 && "$out" -ne 0 ]]; then
        out2=$(identify -format '%[orientation]' "$img" 2>/dev/null)
        echo "$img $out $out2 $rv"


        if $FIX; then
            echo "Fixing..."
            outimg="$(dirname $img)/rotated-$(basename $img)"
            convert -auto-orient "$img" "$outimg"
            mv "$outimg" "$img"
        fi
    fi

done < <(find "$imgdir" -type f -name '*.jpg' -print0)
