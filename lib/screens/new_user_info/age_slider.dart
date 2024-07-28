import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state/sign_up_state_management.dart';
import '../../widgets/authorization_widgets/age_tile.dart';

class AgeSlider extends StatefulWidget {
  const AgeSlider({Key? key}) : super(key: key);

  @override
  State<AgeSlider> createState() => _AgeSliderState();
}

class _AgeSliderState extends State<AgeSlider> {
  late FixedExtentScrollController controller;
  @override
  void initState() {
    super.initState();
    controller = FixedExtentScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              top: 5,
              bottom: 0,
              child: Center(
                child: Container(
                  height: 65,
                  width: MediaQuery.of(context).size.width / 1.1,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.arrow_left,
                        size: 38,
                        color: Colors.white,
                      ),
                      Icon(
                        Icons.arrow_right,
                        size: 38,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Consumer(
              builder: (context, ref, child) => ListWheelScrollView.useDelegate(
                controller: controller,
                itemExtent: 50,
                useMagnifier: true,
                magnification: 1.2,
                perspective: 0.006,
                diameterRatio: 1.2,
                physics: const FixedExtentScrollPhysics(),
                childDelegate: ListWheelChildBuilderDelegate(
                  childCount: 80,
                  builder: (context, index) {
                    return AgeTile(
                      age: index,
                    );
                  },
                ),
                onSelectedItemChanged: (_) => ref
                    .read(ageProvider.notifier)
                    .state = controller.selectedItem,
              ),
            ),
          ],
        ));
  }
}
