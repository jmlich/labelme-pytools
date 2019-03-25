#!/bin/bash


if /bin/true; then

    indir="/var/www/html/fire/bowfire-dataset/dataset-BowFire/dataset/img"
    outdir="/var/www/html/fire/bowfire-dataset/dataset-BowFire/dataset/img_jpg"

    mkdir -p "$outdir"

    for i in $(find "$indir" -type f); do
        fn=$(basename $i .png)
        convert "$indir/${fn}.png" "$outdir/${fn}.jpg"
        echo -n "+"
    done

    echo ""

fi


#./bowfire_convert_mask.py /var/www/html/fire/bowfire-dataset/dataset-BowFire/dataset/img/fire000.png ./y.png
#./bowfire_convert_mask.py /var/www/html/fire/bowfire-dataset/dataset-BowFire/dataset/gt/fire000_gt.png ./y.png


if /bin/true; then

    indir="/var/www/html/fire/bowfire-dataset/dataset-BowFire/dataset/gt"
    outdir="/var/www/html/fire/bowfire-dataset/dataset-BowFire/dataset/gtAug"

    mkdir -p "$outdir"

    for i in $(find "$indir" -type f); do
        fn=$(basename $i);

        base=$(basename $i _gt.png);
    #    echo "$indir/$fn" "$outdir/$fn"
        ./bowfire_convert_mask.py "$indir/$fn" "$outdir/${base}.png"
        echo -n "+"
    done

    echo ""

fi