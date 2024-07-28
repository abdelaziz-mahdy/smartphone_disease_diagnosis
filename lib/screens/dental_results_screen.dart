import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pytorch_lite/pigeon.dart';

import '../widgets/dental_results_widgets/dental_results_details.dart.dart';
import '../widgets/dental_results_widgets/viewresults_card.dart';

class DentalResultsScreen extends StatelessWidget {
  final List<ResultObjectDetection?> detections;
  final File image;
  const DentalResultsScreen(
      {Key? key, required this.image, required this.detections})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    // List<Map<String, dynamic>> diseasesList = detections
    //     .map((e) => {'name': e!.className, 'percentage': e.score})
    //     .toList();

    List<String?> diseaseNames = detections.map((e) => e!.className).toList();

    var diseaseCounts = {};

    for (var element in diseaseNames) {
      if (element != null) {
        if (!diseaseCounts.containsKey(element)) {
          diseaseCounts[element] = 1;
        } else {
          diseaseCounts[element] += 1;
        }
      }
    }

    var diseaseCountList = [];

    diseaseCounts
        .forEach((k, v) => diseaseCountList.add({'name': k, 'count': v}));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                "Diagnosis",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.all(20),
                  height: 55,
                  width: 55,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset:
                              const Offset(0, 1), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(16)),
                  child: Center(
                    child: Text(
                      '${detections.length}',
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Total potential issues",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Detected by our AI",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(top: 20),
                  height: 297,
                  child: Hero(
                    tag: "product.id!",
                    child: Image.asset(
                      'assets/icons/tooth.png',
                      fit: BoxFit.cover,
                      height: 277, //378
                      width: 277,
                    ),
                  ),
                ),
                Expanded(
                    child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: diseaseCountList.length,
                  itemBuilder: (context, i) {
                    return ListTile(
                      title: Text(diseaseCountList[i]['name']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${diseaseCountList[i]['count']} Records',
                            style: const TextStyle(color: Colors.grey),
                          ),
                          const Divider(
                            color: Color(0xffB9BCBE),
                            thickness: 1,
                          ),
                        ],
                      ),
                    );
                  },
                )),
              ],
            ),
            const Row(
              children: [
                Expanded(child: ScaanInfo()),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ViewScanDetailsTile(
                  title: 'View Detailed Analysis',
                  subtitle: 'Extensive report with concern areas ',
                  press: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return DentailResultsDetailsScreen(
                          detections: detections);
                    }));
                  },
                ),
              ],
            ),
          ],
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

class ScaanInfo extends StatelessWidget {
  const ScaanInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 150,
      width: 200,
      // color: Colors.black45,
      child: const SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Results",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              "Results are delivered to you by a well trained AI model that examined your photo. please be aware that this results depends on the light, distance and quality of the pictured attached.",
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
