#!/bin/bash
imgdir='/home/jmlich/workspace/fire/labelme/LabelMeAnnotationTool/Images/fire'
xmldir='/home/jmlich/workspace/fire/labelme/LabelMeAnnotationTool/Annotations/fire'
outdir='/var/www/html/fire/labelme_samples'

rm -rf "$outdir"
mkdir -p "$outdir"

# foreach xml in directory
while IFS= read -r -d $'\0' xml; do

    # find corresponding jpg in directory
    img="$imgdir/$(basename "$xml" .xml).jpg"
    if [ ! -f "$img" ]; then
        echo "Error: Image $(basename "$img") doesn't exists..." >&2
        continue
    fi

    echo "Loading $(basename "$img") $(basename "$xml")"

    ./save_labelme_samples.py "$img" "$xml" "$outdir" 'fire'

done < <(find "$xmldir" -type f -name '*.xml' -print0)

echo "Total files $(find "$outdir" -maxdepth 1 -type f| wc -l)"