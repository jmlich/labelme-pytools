#!/bin/bash
outdir="/home/jmlich/workspace/fire/labelme-pytools/data/Samples"
rm -rf "$outdir"
mkdir -p "$outdir"

./save_labelme_samples.py '/home/jmlich/workspace/fire/labelme/LabelMeAnnotationTool/Images/fire/000092.jpg' '/home/jmlich/workspace/fire/labelme/LabelMeAnnotationTool/Annotations/fire/000092.xml' "$outdir" 'fire'
#./save_labelme_samples.py '/home/jmlich/workspace/fire/labelme/LabelMeAnnotationTool/Images/fire/000570.jpg' '/home/jmlich/workspace/fire/labelme/LabelMeAnnotationTool/Annotations/fire/000570.xml' "$outdir" 'fire'
