import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state/sign_up_state_management.dart';
import '../../widgets/authorization_widgets/gender_icon.dart';

class GenderSlide extends StatefulWidget {
  const GenderSlide({
    Key? key,
  }) : super(key: key);

  @override
  State<GenderSlide> createState() => _GenderSlideState();
}

class _GenderSlideState extends State<GenderSlide> {
  late Gender selectedCard = Gender.unselected;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //the gender containers
                  Consumer(
                    builder: (context, ref, child) => GenderIcon(
                      color: selectedCard == Gender.male
                          ? Colors.blue.shade200
                          : Colors.grey.shade300,
                      icon: Icons.male,
                      label: 'Male',
                      press: () {
                        setState(() {
                          selectedCard = Gender.male;
                          ref.read(genderProvider.notifier).state =
                              selectedCard.toShortString();
                        });
                      },
                    ),
                  ),
                  Consumer(
                    builder: (context, ref, child) => GenderIcon(
                        color: selectedCard == Gender.female
                            ? Colors.pink.shade200
                            : Colors.grey.shade300,
                        icon: Icons.female,
                        label: 'Female',
                        press: () {
                          setState(() {
                            selectedCard = Gender.female;
                            ref.read(genderProvider.notifier).state =
                                selectedCard.toShortString();
                          });
                        }),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}

enum Gender {
  male,
  female,
  unselected,
}

extension Parseenmu on Gender {
  String toShortString() {
    return toString().split('.').last;
  }
}
