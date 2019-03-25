#!/bin/bash

imgdir='/home/jmlich/workspace/fire/sun-dataset/SUN397'
outdir='/var/www/html/fire/dataset-fire-labelme-cropped-Images/---SUN---'
cmaskdir='/var/www/html/fire/dataset-fire-labelme-cropped-Mask/---SUN---'

NUM=${1-2000}

echo $NUM

mkdir -p "$outdir"
mkdir -p "$cmaskdir"

counter=1

isum=0
msum=0

while IFS= read -r -d $'\0' img; do


    bname=$(basename $img .jpg)

    cmask="$cmaskdir/${bname}.png"
    out="$outdir/${bname}.jpg"

# FIXME: test this:
#    if ! identify $img|grep -v "8-bit sRGB"; then
#        echo "Image is grayscale"
#        continue;
#    fi

    if [ ! -f "$out" ]; then
#        convert "$img" -auto-orient -resize 1024x1024 -gravity Center -crop 512x512+0+0 +repage "$out";
        convert "$img" -resize 512x512 "$out";
        isum=$((isum + 1))
    fi
    resolution="$(identify -format "%wx%h" "$out")"

    if [ ! -f "$cmask" ]; then
        msum=$((msum + 1))
        convert -size "$resolution" "xc:#000000" -colorspace Gray "$cmask"
    fi

    echo -n "+"
    if [ "$counter" -ge $NUM ]; then
        break;
    fi

    counter=$(( counter + 1 ))

done < <(find "$imgdir" -type f -name '*.jpg' -print0)

echo ""
echo "isum = $isum; msum = $msum;"


