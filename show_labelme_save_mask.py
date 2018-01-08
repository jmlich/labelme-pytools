#!/usr/bin/python3

import cv2
import numpy as np
import xml.etree.ElementTree as ET
import sys

if __name__ == "__main__":

    if len(sys.argv) != 4:
        print ("usage: {0} image.jpg labelme.xml output.jpg".format(sys.argv[0]))
        sys.exit(1)

    img_filename = sys.argv[1]
    xml_filename = sys.argv[2]
    out_filename = sys.argv[3]

    img = cv2.imread(img_filename)
    tree = ET.parse(xml_filename)

    root = tree.getroot()
    polys = []
    colors = []

    mask = np.zeros(img.shape)
    output = img.copy()
    overlay = img.copy()

    # dictionary colors[tag] = color
    colors = {}

    i = 0

    for obj in root.findall('./object'):
        coords = []
        for pt in obj.findall('./polygon/pt'):
            coords.append([int(pt.find('x').text), int(pt.find('y').text)]) # append coordinate to polygon
        obj_name = obj.find('./name').text

        # each object type have uniq color
        if not obj_name in colors:
            colors[obj_name] = np.random.randint(0,255,(1,3))[0].tolist()
        color = colors[obj_name];


        i = i + 1


        poly = np.array(coords)
        cv2.fillPoly(overlay, [poly], color)
        cv2.fillPoly(mask, [poly], color)
        cv2.polylines(output, [poly], 1, color)

        print (i, obj_name, color, coords)

    print("colors", colors)

    alpha = 0.3
    cv2.addWeighted(overlay, alpha, output, 1 - alpha, 0, output)

#    cv2.imshow("mask", mask)
#    cv2.imshow("img", img)
#   cv2.imshow("output", output)
    cv2.imwrite(out_filename, output)

#    cv2.waitKey(0)

