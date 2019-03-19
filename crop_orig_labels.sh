#!/bin/bash
imgdir='/home/jmlich/workspace/fire/labelme/LabelMeAnnotationTool/Images'
xmldir='/home/jmlich/workspace/fire/labelme/LabelMeAnnotationTool/Annotations'
outdir='/var/www/html/fire/dataset-fire-labelme-cropped-Images'
maskdir='/var/www/html/fire/dataset-fire-labelme-mask'
cmaskdir='/var/www/html/fire/dataset-fire-labelme-cropped-Mask'

msum=0
isum=0
# foreach xml in directory
while IFS= read -r -d $'\0' xml; do
    xml=$(realpath "$xml")

    bname=$(echo $xml | sed "s|^$xmldir/||" | sed 's|\.xml$||')
    # find corresponding jpg in directory
    img="$imgdir/${bname}.jpg"
    out="$outdir/${bname}.jpg"
    mask="$maskdir/${bname}.png"
    cmask="$cmaskdir/${bname}.png"

    outdirfull="$(dirname "$out")"
    maskdirfull="$(dirname "$mask")"
    cmaskdirfull="$(dirname "$cmask")"


    if [ ! -f "$img" ]; then
        echo "Error: Image '$img' doesn't exists..." >&2
#        rm -f "$xml"
        continue
    fi

    if [ ! -f "$mask" ]; then
        echo "Error: mask '$mask' doesn't exits..." >&2
        continue
    fi

    mkdir -p "$outdirfull"
    mkdir -p "$maskdirfull"
    mkdir -p "$cmaskdirfull"

    if [ ! -f "$cmask" ]; then
#        convert "$mask" -auto-orient -interpolate nearest-neighbor -resize 1024x1024 -gravity Center -crop 512x512+0+0 +repage "$cmask";
        convert "$mask" -interpolate nearest-neighbor -resize 512x512 "$cmask";
        msum=$((msum + 1))
    fi

    if [ ! -f "$out" ]; then
#        convert "$img" -auto-orient -resize 1024x1024 -gravity Center -crop 512x512+0+0 +repage "$out";
        convert "$img" -resize 512x512 "$out";
        isum=$((isum + 1))
    fi

    echo -n "+"

done < <(find "$xmldir" -type f -name '*.xml' -print0)

echo ""
echo "isum = $isum; msum = $msum;"


