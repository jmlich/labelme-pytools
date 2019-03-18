#!/usr/bin/python3

import os
import json
import cv2
import numpy as np
import xml.etree.ElementTree as ET
import sys

if __name__ == "__main__":

    if (len(sys.argv) != 4) and (len(sys.argv) != 5):
        print ("usage: {0} image.jpg labelme.xml output.jpg [mask.png]".format(sys.argv[0]))
        sys.exit(1)

    img_filename = sys.argv[1]
    xml_filename = sys.argv[2]
    out_filename = sys.argv[3]
    if (len(sys.argv) == 5):
        out_mask_filename = sys.argv[4]

    img = cv2.imread(img_filename)
    tree = ET.parse(xml_filename)

    root = tree.getroot()
    polys = []
    colors = []

    mask = np.zeros((img.shape[0], img.shape[1], 1))
    output = img.copy()
    overlay = img.copy()

    # dictionary colors[tag] = color
    colors = {}
    colors_mask = {}


    if os.path.isfile('colors_mask.json'):
        with open('colors_mask.json') as json_file:
            colors_mask = json.load(json_file)

    if os.path.isfile('colors.json'):
        with open('colors.json') as json_file:
            colors = json.load(json_file)

    for obj in root.findall('./object'):
        coords = []
        for pt in obj.findall('./polygon/pt'):
            coords.append([int(pt.find('x').text), int(pt.find('y').text)]) # append coordinate to polygon
        obj_name = obj.find('./name').text

        # each object type have uniq color
        if not obj_name in colors:
            colors[obj_name] = np.random.randint(0,255,(1,3))[0].tolist()
        color = colors[obj_name];

        if not obj_name in colors_mask:
            colors_mask[obj_name] = ( len(colors_mask)+1 )
        color_mask = colors_mask[obj_name];

        poly = np.array(coords)
        cv2.fillPoly(overlay, [poly], color)
        cv2.fillPoly(mask, [poly], color_mask)
        cv2.polylines(output, [poly], 1, color)

#        print (obj_name, color, coords)

    print("tags: ", colors_mask)

    with open('colors_mask.json', 'w') as file:
        file.write(json.dumps(colors_mask))

    with open('colors.json', 'w') as file:
        file.write(json.dumps(colors))

    alpha = 0.6
    cv2.addWeighted(overlay, alpha, output, 1 - alpha, 0, output)

#    cv2.imshow("mask", mask)
#    cv2.imshow("img", img)
#   cv2.imshow("output", output)
    cv2.imwrite(out_filename, output)
    if (len(sys.argv) == 5):
        cv2.imwrite(out_mask_filename, mask)

#    cv2.waitKey(0)

