// ignore_for_file: must_be_immutable

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pytorch_lite/pigeon.dart';
import 'package:pytorch_lite/pytorch_lite.dart';
import 'package:smartphone_disease_diagnosis/screens/dental_results_screen.dart';
import '../state/models_state_management.dart';

class DentalModel extends ConsumerWidget {
  List<ResultObjectDetection?> objDetect = [];

  DentalModel({
    Key? key,
  }) : super(key: key);

  Future runObjectDetection(
      ModelObjectDetection objectModel, File image) async {
    objDetect = await objectModel.getImagePrediction(
        await File(image.path).readAsBytes(),
        minimumScore: 0.1,
        IOUThershold: 0.3);
    // for (var element in objDetect) {
    //   print({
    //     "score": element?.score,
    //     "className": element?.className,
    //     "class": element?.classIndex,
    //     "rect": {
    //       "left": element?.rect.left,
    //       "top": element?.rect.top,
    //       "width": element?.rect.width,
    //       "height": element?.rect.height,
    //       "right": element?.rect.right,
    //       "bottom": element?.rect.bottom,
    //     },
    //   });
    // }

    return objDetect;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final objectModelProvider = ref.watch(modelProvider);
    final image = ref.watch(imageProvider);
    return objectModelProvider.value == null
        ? const Scaffold(
          body: Center(
              child: Text('Loading....'),
            ),
        )
        : image == null
            ? const Center(
                child: Text('Oops! Failed to Load image....'),
              )
            : FutureBuilder(
                future:
                    runObjectDetection(objectModelProvider.value![1], image),
                builder: (ctx, snapshot) {
                  // Checking if future is resolved or not
                  if (snapshot.connectionState == ConnectionState.done) {
                    // If we got an error
                    if (snapshot.hasError) {
                      return Scaffold(
                        body: Center(
                          child:
                              Text('Something went wrong: ${snapshot.error}'),
                        ),
                      );

                      // if we got our data
                    } else if (snapshot.hasData) {
                      // Extracting data from snapshot object

                      return DentalResultsScreen(
                        image: image,
                        detections: objDetect,
                      );
                    }
                  }

                  // Displaying LoadingSpinner to indicate waiting state
                  return const Scaffold(
                    body: Center(
                      child: Text('Loading....'),
                    ),
                  );
                },
              );
  }
}
