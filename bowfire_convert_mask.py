#!/usr/bin/python3

import os
import cv2
import numpy as np
import sys

def threshold_slow(T, image):
    # grab the image dimensions

    mask = image >= T
    image[mask] = 1
    image[np.logical_not(mask)] = 0

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


