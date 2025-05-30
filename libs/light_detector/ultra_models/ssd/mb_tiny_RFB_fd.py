# -*-coding: utf-8 -*-

from torch.nn import Conv2d, Sequential, ModuleList, ReLU
from ultra_models.nn.mb_tiny_RFB import Mb_Tiny_RFB
from ultra_models.ssd.ssd import SSD


def SeperableConv2d(in_channels, out_channels, kernel_size=1, stride=1, padding=0):
    """Replace Conv2d with a depthwise Conv2d and Pointwise Conv2d.
    """
    return Sequential(
        Conv2d(in_channels=in_channels, out_channels=in_channels, kernel_size=kernel_size,
               groups=in_channels, stride=stride, padding=padding),
        ReLU(),
        Conv2d(in_channels=in_channels, out_channels=out_channels, kernel_size=1),
    )


def create_mb_tiny_rfb_fd(prior_boxes, num_classes, is_test=False, width_mult=1.0, device="cuda:0"):
    """
    create_Mb_Tiny_RFB_fd_predictor
    min_boxes = [[10, 16, 24], [32, 48], [64, 96], [128, 192, 256]]  # for Face
    x=torch.Size([24, 64, 30, 40]), location:torch.Size([24, 12, 30, 40])location-view:torch.Size([24, 3600, 4])
    x=torch.Size([24, 128, 15, 20]),location:torch.Size([24, 8, 15, 20]) location-view:torch.Size([24, 600, 4])
    x=torch.Size([24, 256, 8, 10]), location:torch.Size([24, 8, 8, 10])  location-view:torch.Size([24, 160, 4])
    x=torch.Size([24, 256, 4, 5]),  location:torch.Size([24, 12, 4, 5])  location-view:torch.Size([24, 60, 4])
    :param num_classes:
    :param is_test:
    :param device:
    :return:
    """
    base_net = Mb_Tiny_RFB(num_classes)
    base_net_model = base_net.model  # disable dropout layer

    source_layer_indexes = [8, 11, 17]
    extras = ModuleList([
        Sequential(
            Conv2d(in_channels=base_net.base_channel * 16, out_channels=base_net.base_channel * 4, kernel_size=1),
            ReLU(),
            SeperableConv2d(in_channels=base_net.base_channel * 4, out_channels=base_net.base_channel * 16,
                            kernel_size=3, stride=2, padding=1),
            ReLU()
        )
    ])

    boxes_expand = [len(boxes) * (len(prior_boxes.aspect_ratios)) for boxes in prior_boxes.min_boxes]
    regression_headers = ModuleList([
        SeperableConv2d(in_channels=base_net.base_channel * 4,
                        out_channels=boxes_expand[0] * 4,
                        kernel_size=3,
                        padding=1),
        SeperableConv2d(in_channels=base_net.base_channel * 8,
                        out_channels=boxes_expand[1] * 4,
                        kernel_size=3,
                        padding=1),
        SeperableConv2d(in_channels=base_net.base_channel * 16,
                        out_channels=boxes_expand[2] * 4,
                        kernel_size=3,
                        padding=1),
        Conv2d(in_channels=base_net.base_channel * 16,
               out_channels=boxes_expand[3] * 4,
               kernel_size=3,
               padding=1)])

    classification_headers = ModuleList([
        SeperableConv2d(in_channels=base_net.base_channel * 4,
                        out_channels=boxes_expand[0] * num_classes,
                        kernel_size=3,
                        padding=1),
        SeperableConv2d(in_channels=base_net.base_channel * 8,
                        out_channels=boxes_expand[1] * num_classes,
                        kernel_size=3,
                        padding=1),
        SeperableConv2d(in_channels=base_net.base_channel * 16,
                        out_channels=boxes_expand[2] * num_classes,
                        kernel_size=3,
                        padding=1),
        Conv2d(in_channels=base_net.base_channel * 16,
               out_channels=boxes_expand[3] * num_classes,
               kernel_size=3,
               padding=1)])

    return SSD(num_classes, base_net_model, source_layer_indexes,
               extras, classification_headers, regression_headers, is_test=is_test, prior_boxes=prior_boxes,
               device=device)