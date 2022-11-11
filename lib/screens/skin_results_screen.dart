import 'dart:io';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class SkinRes extends StatelessWidget {
  final File? takenImage;
  final String? diseaseName;
  final double? diagnosisProbability;

  const SkinRes({
    Key? key,
    required this.takenImage,
    required this.diseaseName,
    required this.diagnosisProbability,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            SizedBox(
              width: width,
              height: height * 0.6,
              child: Center(
                child: CircularPercentIndicator(
                  animation: true,
                  radius: 140.0,
                  lineWidth: 20.0,
                  percent: diagnosisProbability == null
                      ? 0
                      : diagnosisProbability! / 100,
                  progressColor: const Color.fromARGB(255, 127, 164, 248),
                  backgroundColor: Colors.white,
                  circularStrokeCap: CircularStrokeCap.round,
                  center: Image.asset(
                    'assets/icons/skinresults.png',
                    height: 200,
                    width: 200,
                  ),
                ),
              ),
            ),
            Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Text(
                              diseaseName == null ? 'No disease' : diseaseName!,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Hero(
                            tag: 'img1',
                            child: Image(
                              height: 60,
                              width: 80,
                              image: FileImage(takenImage!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Confidence',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.pink[200],
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                diagnosisProbability == null
                                    ? '0.0 %'
                                    : '${diagnosisProbability!.toStringAsFixed(2)} %',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 21,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 80,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                        content: Hero(
                                      tag: 'img1',
                                      child: Image(
                                        image: FileImage(takenImage!),
                                      ),
                                    ));
                                  });
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                const Color.fromRGBO(130, 102, 117, 1),
                              ),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 10),
                              child: Text(
                                'View Photo',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )),
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
