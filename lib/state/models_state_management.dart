import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pytorch_lite/pytorch_lite.dart';

final modelProvider = FutureProvider<List?>((ref) async {
  String pathImageModel = "assets/models/yolo_x_Skin.torchscript";
  String pathObjectDetectionModel =
      "assets/models/Dental_cleaned_labels_best.torchscript";
  final ClassificationModel? imageModel;
  final ModelObjectDetection? objectModel;
  try {
    imageModel = await PytorchLite.loadClassificationModel(
        pathImageModel, 512, 512, 6,
        labelPath: "assets/labels/skin_model_(labels_cleaned)_yolox .txt");

    objectModel = await PytorchLite.loadObjectDetectionModel(
        pathObjectDetectionModel, 14, 640, 640,
        labelPath: "assets/labels/labelmap_dental_cleaned_labels.txt");

    return [imageModel, objectModel];
  } on PlatformException {
    //print("only supported for android");
    return null;
  }
});

final imageProvider = StateProvider<File?>((ref) => null);
