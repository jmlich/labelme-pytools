#!/usr/bin/python3

import os
import cv2
import numpy as np
import sys

def threshold_slow(T, image):
    # grab the image dimensions
    h = image.shape[0]
    w = image.shape[1]

    # loop over the image, pixel by pixel
    for y in range(0, h):
        for x in range(0, w):
            # threshold the pixel
            image[y, x] = 1 if image[y, x] >= T else 0
#            image[y, x] = 255 if image[y, x] >= T else 0

    # return the thresholded image
    return image

if __name__ == "__main__":

    if (len(sys.argv) != 3) :
        print ("usage: {0} in/mask001.png out/mask001.png".format(sys.argv[0]))
        sys.exit(1)

    in_filename = sys.argv[1]
    out_filename = sys.argv[2]

    mask_in = cv2.imread(in_filename)
    mask_in_gray = cv2.cvtColor(mask_in, cv2.COLOR_BGR2GRAY)

    mask_out = threshold_slow(100, mask_in_gray )

    cv2.imwrite(out_filename, mask_out)


