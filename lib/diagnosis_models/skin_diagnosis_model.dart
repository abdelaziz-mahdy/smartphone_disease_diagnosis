// ignore_for_file: must_be_immutable

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pytorch_lite/pytorch_lite.dart';
import '../screens/skin_results_screen.dart';
import '../state/models_state_management.dart';

class SkinModel extends ConsumerWidget {
  String? _imagePrediction;
  double? probability;

  SkinModel({
    Key? key,
  }) : super(key: key);

  Future<List> runClassification(
      ClassificationModel imageModel, File image) async {
    //get prediction
    List<double?>? predictionListProbabilites =
        await imageModel.getImagePredictionListProbabilities(
      await File(image.path).readAsBytes(),
    );

    // print('pb $predictionListProbabilites');
    //Gettting the highest Probability
    double maxScoreProbability = double.negativeInfinity;
    double sumOfProbabilites = 0;
    int index = 0;
    for (int i = 0; i < predictionListProbabilites!.length; i++) {
      if (predictionListProbabilites[i]! > maxScoreProbability) {
        maxScoreProbability = predictionListProbabilites[i]!;
        sumOfProbabilites = sumOfProbabilites + predictionListProbabilites[i]!;
        index = i;
      }
    }

    _imagePrediction = imageModel.labels[index];
    probability = maxScoreProbability * 100;

    // print('prediction $_imagePrediction');
    // print('probability $probability');

    return [_imagePrediction, probability];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageModelProvider = ref.watch(modelProvider);
    final image = ref.watch(imageProvider);

    return imageModelProvider.value == null
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
                future: runClassification(imageModelProvider.value![0], image),
                builder: (ctx, snapshot) {
                  // Checking if future is resolved or not
                  if (snapshot.connectionState == ConnectionState.done) {
                    // If we got an error
                    if (snapshot.hasError) {
                      return Scaffold(
                        body: Center(
                          child: Text('Something went wrong: ${snapshot.error}'),
                        ),
                      );

                      // if we got our data
                    } else if (snapshot.hasData) {
                      // Extracting data from snapshot object
                      return SkinRes(
                          takenImage: image,
                          diseaseName: (snapshot.data as List)[0],
                          diagnosisProbability: (snapshot.data as List)[1]);
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
