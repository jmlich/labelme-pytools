#!/bin/bash

imgdir='/home/jmlich/workspace/fire/labelme/LabelMeAnnotationTool/Images'

while IFS= read -r -d $'\0' img; do

    if ! identify -verbose -regard-warnings "$img" >/dev/null 2>&1; then
        echo $img
    fi

done < <(find "$imgdir" -type f -name '*.jpg' -print0)
