#!/bin/bash
imgdir='/home/jmlich/workspace/fire/labelme/LabelMeAnnotationTool/Images'
xmldir='/home/jmlich/workspace/fire/labelme/LabelMeAnnotationTool/Annotations'
outdir='/var/www/html/fire/dataset-fire-labelme-with-poly'
maskdir='/var/www/html/fire/dataset-fire-labelme-mask'
mkdir -p "$outdir"
mkdir -p "$maskdir"

rm -f "colors_mask.json"
rm -f "colors.json"

sum=0
sum_out=0
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
#        rm -f "$xml"
        continue
    fi

    mkdir -p "$outdirfull"
    mkdir -p "$maskdirfull"

    if [ -f "$out" ]; then
        sum_out=$((sum_out + 1))
        echo -n "+"
        continue;
    fi

    if [ -f "$mask" ]; then
        sum_out=$((sum_out + 1))
        echo -n "*"
        continue;
    fi

    ./save_labelme.py "$img" "$xml" "$out" "$mask" #> /dev/null
    sum=$((sum + 1))

done < <(find "$xmldir" -type f -name '*.xml' -print0)


echo ""
echo "skipped = $sum_out; converted = $sum"