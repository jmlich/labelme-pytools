#!/usr/bin/python3

"""
- walk over image with window 48x48 and step 16x16
- check if center pixel is in class defined in argv
- renders every such region in separate picture
- downscale twice and repeat when possible

"""

import cv2
import numpy as np
import xml.etree.ElementTree as ET
import sys
import os
import math

if __name__ == "__main__":

    if len(sys.argv) != 5:
        print ("usage: {0} image.jpg labelme.xml outdir label".format(sys.argv[0]))
        sys.exit(1)

    img_filename = sys.argv[1]
    xml_filename = sys.argv[2]
    out_dir = sys.argv[3]
    label = sys.argv[4]

    img = cv2.imread(img_filename)
    tree = ET.parse(xml_filename)


    root = tree.getroot()
    polys = []
    colors = []

    mask = np.zeros(img.shape)
    output = img.copy()
    overlay = img.copy()


    color = (255,255,255)
    sample_prefix = os.path.splitext(os.path.basename(img_filename))[0]
    sample_counter = 0

    # prepare mask image

    for obj in root.findall('./object'):
        coords = []
        for pt in obj.findall('./polygon/pt'):
            coords.append([int(pt.find('x').text), int(pt.find('y').text)]) # append coordinate to polygon
        obj_name = obj.find('./name').text
        if obj_name != label:
            print (("Skipping label \"{0}\" ...").format(obj_name))
            continue;


        poly = np.array(coords)
        cv2.fillPoly(overlay, [poly], color)
        cv2.fillPoly(mask, [poly], color)
        cv2.polylines(output, [poly], 1, color)

#        print (obj_name, color, coords)

    height=(int)((img.shape[0])/16 - 3)
    width=(int)((img.shape[1])/16 - 3)
    levels = math.floor ( max(math.log2(height), math.log2(width)) )

    for level in range(0, levels):
        scale = math.pow(2, level)
        height=(int)(((img.shape[0])/16/scale - 3))
        width=(int)(((img.shape[1])/16/scale - 3))

        if height <= 0 or width <= 0:
            break;

#        print("{}x{}x{}".format(width,height, scale))

        for y in range(0, height):
            for x in range(0, width):
                roix=(int)(x*16*scale)
                roiy=(int)(y*16*scale)
                mask_point_x = (int)(roix+16*2*scale)
                mask_point_y = (int)(roiy+16*2*scale)
                mask_point=mask[mask_point_y, mask_point_x]
#                if (mask_point[0] > 0):
#                    sys.stdout.write("X")
#                else:
#                    sys.stdout.write(" ")
                if (mask_point[0] > 0):
                    x2 = (int)(roix+16*3*scale)
                    y2 = (int)(roiy+16*3*scale)
                    roi=img[roiy:y2, roix:x2]

                    sample_filename = ("{}/{}_{}.jpg".format(out_dir, sample_prefix, sample_counter))
                    cv2.imwrite(sample_filename, cv2.resize(roi, (48, 48)))
                    sample_counter += 1

#            print("")

    print(sample_counter)

#    alpha = 0.3
#    cv2.addWeighted(overlay, alpha, output, 1 - alpha, 0, output)

#    cv2.imshow("mask", mask)
#    cv2.imshow("img", img)
#    cv2.imshow("output", output)

#    cv2.waitKey(0)

