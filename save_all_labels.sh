#!/bin/bash
imgdir='/home/jmlich/workspace/fire/labelme/LabelMeAnnotationTool/Images/fire'
xmldir='/home/jmlich/workspace/fire/labelme/LabelMeAnnotationTool/Annotations/fire'
outdir='/var/www/html/fire/labelme'

# foreach xml in directory
while IFS= read -r -d $'\0' xml; do

    # find corresponding jpg in directory
    img="$imgdir/$(basename "$xml" .xml).jpg"
    out="$outdir/$(basename "$xml" .xml).jpg"
    if [ ! -f "$img" ]; then
        echo "Error: Image $(basename "$img") doesn't exists..." >&2
        continue
    fi

    echo "Loading $(basename "$img") $(basename "$xml")"
    ./save_labelme.py "$img" "$xml" "$out" > /dev/null

done < <(find "$xmldir" -type f -name '*.xml' -print0)

