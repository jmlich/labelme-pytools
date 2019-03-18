#!/bin/bash
imgdir='/home/jmlich/workspace/fire/labelme/LabelMeAnnotationTool/Images'
xmldir='/home/jmlich/workspace/fire/labelme/LabelMeAnnotationTool/Annotations'
outdir='/var/www/html/fire/flick-fire-labelme'
maskdir='/var/www/html/fire/flick-fire-labelme-mask'
mkdir -p "$outdir"
mkdir -p "$maskdir"

rm -f "colors_mask.json"
rm -f "colors.json"

# foreach xml in directory
while IFS= read -r -d $'\0' xml; do
    xml=$(realpath "$xml")

    bname=$(echo $xml | sed "s|^$xmldir/||" | sed 's|\.xml$||')
    # find corresponding jpg in directory
    img="$imgdir/${bname}.jpg"
    out="$outdir/${bname}.jpg"
    mask="$maskdir/${bname}.png"

    outdirfull="$(dirname "$out")"
    maskdirfull="$(dirname "$mask")"


    if [ ! -f "$img" ]; then
        echo "Error: Image '$img' doesn't exists..." >&2
        continue
    fi

    mkdir -p "$outdirfull"
    mkdir -p "$maskdirfull"


    echo "+ ./save_labelme.py \"$img\" \"$xml\" \"$out\" \"$mask\""
    ./save_labelme.py "$img" "$xml" "$out" "$mask" #> /dev/null

done < <(find "$xmldir" -type f -name '*.xml' -print0)

