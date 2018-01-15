#!/usr/bin/python3

import cv2
import numpy as np
import xml.etree.ElementTree as ET
import sys
import os

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

    height=(int)((img.shape[0])/16) - 3
    width=(int)((img.shape[1])/16) - 3
    for y in range(0, height):
        for x in range(0, width):
            roix=x*16
            roiy=y*16
            mask_point=mask[roiy+24, roix+24]

            if (mask_point[0] > 0):
                roi=img[roiy:roiy+48, roix:roix+48]
                sample_filename = ("{}/{}_{}.jpg".format(out_dir, sample_prefix, sample_counter))
                cv2.imwrite(sample_filename, roi)
                sample_counter += 1;


#            print(mask_point[0])
#            if (mask_point[0] > 0):
#                sys.stdout.write("X")
#            else:
#                sys.stdout.write(" ")
#        print("\n")

    print(sample_counter)

#    alpha = 0.3
#    cv2.addWeighted(overlay, alpha, output, 1 - alpha, 0, output)

#    cv2.imshow("mask", mask)
#    cv2.imshow("img", img)
#    cv2.imshow("output", output)

#    cv2.waitKey(0)

