import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vertical_weight_slider/vertical_weight_slider.dart';

import '../../state/sign_up_state_management.dart';


class WeightSlider extends StatefulWidget {
  const WeightSlider({Key? key}) : super(key: key);
  @override
  _WeightSliderState createState() => _WeightSliderState();
}

class _WeightSliderState extends State<WeightSlider> {
  late WeightSliderController _controller;
  double _weight = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = WeightSliderController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Text(
            "${_weight.toStringAsFixed(1)} kg",
            style:
                const TextStyle(fontSize: 30.0, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 20,
          ),
          Consumer(
            builder: (context, ref, child) => VerticalWeightSlider(
              controller: _controller,
              decoration: const PointerDecoration(
                width: 130.0,
                height: 3.0,
                largeColor: Color(0xFF898989),
                mediumColor: Color(0xFFC5C5C5),
                smallColor: Color(0xFFF0F0F0),
                gap: 30.0,
              ),
              onChanged: (val) => setState(() {
                _weight = val;
                ref.read(weightProvider.notifier).state = _weight;
              }),
              indicator: Container(
                height: 3.0,
                width: 200.0,
                alignment: Alignment.centerLeft,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
