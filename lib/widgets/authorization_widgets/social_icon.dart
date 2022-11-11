import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class SocialIcon extends StatelessWidget {
  const SocialIcon({Key? key, required this.iconName, required this.press})
      : super(key: key);
  final String iconName;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: press,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Image(
              image: Svg(iconName),
              height: 20,
              width: 20,
              color: Colors.blue,
            ),
          ),
        ),
      ],
    );
  }
}
