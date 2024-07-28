// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smartphone_disease_diagnosis/diagnosis_models/dental_diagnosis_model.dart';
import 'package:smartphone_disease_diagnosis/diagnosis_models/skin_diagnosis_model.dart';
import 'package:smartphone_disease_diagnosis/state/models_state_management.dart';

class DiagnosisImageWidget extends StatelessWidget {
  final String diagnosisModel;
  final VoidCallback closeHandler;
  File? _image;
  DiagnosisImageWidget({
    Key? key,
    required this.closeHandler,
    required this.diagnosisModel,
  }) : super(key: key);

  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      _image = File(image.path);
    } on PlatformException catch (e) {
      print('failed to pick image $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Upload',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                IconButton(
                  onPressed: closeHandler,
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            Consumer(
              builder: (context, ref, child) => TextButton.icon(
                onPressed: () async {
                  await _pickImage(ImageSource.camera).then(
                    (_) {
                      if (_image == null) return;
                      ref.read(imageProvider.notifier).state = _image;
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => diagnosisModel == 'skin'
                              ? SkinModel()
                              : DentalModel(),
                        ),
                      );
                    },
                  );
                },
                icon: const Icon(Icons.camera),
                label: const Text('Camera'),
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.black),
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.fromLTRB(0, 10, 20, 5),
                  ),
                ),
              ),
            ),
            Consumer(
              builder: (context, ref, child) => 
              TextButton.icon(
                onPressed: () async {
                  await _pickImage(ImageSource.gallery).then(
                    (_) {
                      if (_image == null) return;
                      ref.read(imageProvider.notifier).state = _image;
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => diagnosisModel == 'skin'
                              ? SkinModel()
                              : DentalModel(),
                        ),
                      );
                    },
                  );
                },
                icon: const Icon(Icons.photo_library),
                label: const Text('Gallery'),
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.black),
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.fromLTRB(0, 10, 20, 5),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
