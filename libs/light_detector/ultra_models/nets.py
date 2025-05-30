# -*- coding: utf-8 -*-


import cv2
import torch
import numpy as np
from ultra_models.ssd.mb_tiny_fd import create_mb_tiny_slim_fd
from ultra_models.ssd.mb_tiny_RFB_fd import create_mb_tiny_rfb_fd
from ultra_models.ssd.mb_tiny_RFB_landms import create_mb_tiny_rfb_landms
from ultra_models.ssd.mobilenet_v2_ssd_lite import create_mobilenetv2_ssd_lite
from ultra_models.ssd.mobilenet_v2_ssd_landms import create_mobilenetv2_ssd_landms


def build_net(net_type, prior_boxes, num_classes, width_mult, is_test=False, device="cuda:0"):
    if net_type.lower() == 'slim'.lower():
        create_net = create_mb_tiny_slim_fd
    elif net_type.lower() == 'RFB'.lower():
        create_net = create_mb_tiny_rfb_fd
    elif net_type.lower() == 'mbv2'.lower():
        create_net = create_mobilenetv2_ssd_lite
    elif net_type.lower() == 'RFB_landms'.lower():
        create_net = create_mb_tiny_rfb_landms
    elif net_type.lower() == 'mbv2_landms'.lower():
        create_net = create_mobilenetv2_ssd_landms
    else:
        create_net = None
        raise Exception("The net type is wrong.")
    net = create_net(prior_boxes=prior_boxes,
                     num_classes=num_classes,
                     is_test=is_test,
                     device=device,
                     width_mult=width_mult)
    return net
