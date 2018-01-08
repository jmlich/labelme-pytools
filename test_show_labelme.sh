#!/bin/bash
#./show_labelme.py '/home/jmlich/workspace/fire/labelme/LabelMeAnnotationTool/Images/fire/000092.jpg' '/home/jmlich/workspace/fire/labelme/LabelMeAnnotationTool/Annotations/fire/000092.xml'
#./show_labelme.py '/home/jmlich/workspace/fire/labelme/LabelMeAnnotationTool/Images/fire/000570.jpg' '/home/jmlich/workspace/fire/labelme/LabelMeAnnotationTool/Annotations/fire/000570.xml'

./show_labelme_save_mask.py '/home/jmlich/workspace/fire/labelme/LabelMeAnnotationTool/Images/fire/000092.jpg' '/home/jmlich/workspace/fire/labelme/LabelMeAnnotationTool/Annotations/fire/000092.xml' './local1.jpg'
./show_labelme_save_mask.py '/home/jmlich/workspace/fire/labelme/LabelMeAnnotationTool/Images/fire/000570.jpg' '/home/jmlich/workspace/fire/labelme/LabelMeAnnotationTool/Annotations/fire/000570.xml' './local2.jpg'
