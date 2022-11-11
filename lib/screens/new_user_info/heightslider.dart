import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state/sign_up_state_management.dart';


class HeightSlider extends StatefulWidget {
  const HeightSlider({Key? key}) : super(key: key);
  @override
  _HeightSliderState createState() => _HeightSliderState();
}

class _HeightSliderState extends State<HeightSlider> {
  int heightc = 180;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Icon(
                  Icons.boy,
                  size: 50,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      heightc.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 50, fontWeight: FontWeight.w600),
                    ),
                    const Text(
                      'cm',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30.0,
                      ),
                    ),
                  ],
                ),
                const Icon(
                  Icons.boy,
                  size: 70,
                ),
              ],
            ),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                  thumbColor: Colors.white,
                  thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10.0),
                  overlayShape: const RoundSliderOverlayShape(overlayRadius: 20.0)),
              child: Consumer(
                builder: (context, ref, child) => Slider(
                  value: heightc.toDouble(),
                  min: 50.0,
                  max: 200.0,
                  activeColor: Colors.blue,
                  inactiveColor: Colors.grey,
                  onChanged: (double newvalue) {
                    setState(() {
                      heightc = newvalue.round();
                      ref.read(heightProvider.notifier).state = heightc;
                    });
                  },
                ),
              ),
            )
          ],
        ));
  }
}
