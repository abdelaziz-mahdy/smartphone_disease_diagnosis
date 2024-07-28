import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pytorch_lite/pigeon.dart';
import 'package:pytorch_lite/pytorch_lite.dart';

import 'package:smartphone_disease_diagnosis/state/models_state_management.dart';

class DentailResultsDetailsScreen extends StatelessWidget {
  final List<ResultObjectDetection?> detections;

  const DentailResultsDetailsScreen({Key? key, required this.detections})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Card(
            child: Column(
              children: [
                Consumer(
                  builder: (context, ref, child) {
                    final image = ref.watch(imageProvider);
                    final objectModel = ref.watch(modelProvider);

                    if (objectModel.value != null) {
                      return ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        child: SizedBox(
                          height: 300,
                          child: (objectModel.value![1] as ModelObjectDetection)
                              .renderBoxesOnImage(image!, detections),
                        ),
                      );
                    } else {
                      return const ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        child: SizedBox(
                            height: 300,
                            child: Center(child: Text('Loading...'))),
                      );
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Issue',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink[200],
                        ),
                      ),
                      Text(
                        '%',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink[200],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Divider(
                    color: Colors.pink[200],
                    thickness: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SizedBox(
                    height: 300,
                    child: ListView.builder(
                      itemCount: detections.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 3,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              detections[index]!.className!,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              (detections[index]!.score * 100)
                                  .toStringAsFixed(2),
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
