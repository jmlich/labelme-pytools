#!/bin/bash

imgdir='/home/jmlich/workspace/fire/sun-dataset/SUN397'
outdir='/var/www/html/fire/dataset-fire-labelme-cropped-Images/---SUN---'
cmaskdir='/var/www/html/fire/dataset-fire-labelme-cropped-Mask/---SUN---'

NUM=${1-1000}

echo $NUM

mkdir -p "$outdir"
mkdir -p "$cmaskdir"

counter=1

isum=0
msum=0

#
# $1 filename of input image
#

function prepare_negative_data_img() {
    local img="$1"

    bname="$(basename "$img" .jpg)"
    cmask="$cmaskdir/${bname}.png"
    out="$outdir/${bname}.jpg"

    if [ -z "$img" ]; then
        echo "Empty filename \"$img\"" >&2
        return
    fi

# FIXME
#    if ! identify "$img"|grep "8-bit sRGB"; then
#        echo "Image \"$img\" is grayscale" >&2
#        return
#    fi

    if [ ! -f "$out" ]; then
#        convert "$img" -auto-orient -resize 1024x1024 -gravity Center -crop 512x512+0+0 +repage "$out";
        convert "$img" -auto-orient -resize 512x512 "$out";
        isum=$((isum + 1))
    fi
    resolution="$(identify -format "%wx%h" "$out")"

    if [ ! -f "$cmask" ]; then
        msum=$((msum + 1))
        convert -size "$resolution" "xc:#000000" -colorspace Gray "$cmask"
    fi
}

while IFS= read -r img; do
    prepare_negative_data_img "$img"
done < "./sun_fire_detected_run2.txt"

while IFS= read -r img; do
    prepare_negative_data_img "$img"
done < <(find "$imgdir" -type f -name '*.jpg'|sort -R|head -n $NUM)


echo ""
echo "isum = $isum; msum = $msum;"


