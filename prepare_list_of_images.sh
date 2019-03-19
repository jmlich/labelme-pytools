#!/bin/bash

out_all="./_all.txt"
out_train="./train.txt"
out_test="./test.txt"
out_val="./val.txt"

train_percent=50 # %
test_percent=25 # %
# val_percent=$(( 100 - train_percent - test_percent ))



if [ ! -f $out_all ]; then

    basedir='/var/www/html/fire/'
    images='dataset-fire-labelme-cropped-Images'
    masks='dataset-fire-labelme-cropped-Mask'

    full_images=$(realpath "$basedir/$images")
    full_masks=$(realpath "$basedir/$masks")

    while IFS= read -r -d $'\0' image; do
        image=$(realpath "$image")

        bname=$(echo $image | sed "s|^$full_images/||" | sed 's|.jpg$||')

        rel_image="${bname}.jpg"
        rel_mask="${bname}.png"
        if [ ! -f "$full_masks/$rel_mask" ]; then
            echo "Error: mask '$rel_mask' not found" >&2
            continue;
        fi
        echo "$bname"

    done < <(find "$full_images" -type f -name '*.jpg' -print0) | sort -R > "$out_all"

fi

data_set_size=$(wc -l _all.txt | cut -f 1 -d " ")
train_set_size=$(bc <<< "scale=0; ($train_percent * $data_set_size)/100")
test_set_size=$(bc <<< "scale=0; ($test_percent * $data_set_size)/100")
val_set_size=$(( data_set_size - train_set_size - test_set_size ))
echo "train_set_size = $train_set_size; test_set_size = $test_set_size; val_set_size = $val_set_size"
head "$out_all" -n "$train_set_size" > "$out_train"
head "$out_all" -n "$((train_set_size + test_set_size))" | tail -n $test_set_size > "$out_test"
tail "$out_all" -n "$val_set_size" > "$out_val"

