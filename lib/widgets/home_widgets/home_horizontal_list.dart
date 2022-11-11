import 'package:flutter/material.dart';

class HomeHorizontalWidget extends StatelessWidget {
  const HomeHorizontalWidget(
      {Key? key,
      required this.pannarTitle,
      required this.pannerDiscribtion,
      required this.pannarImage,
      required this.pannarColor})
      : super(key: key);
  final int pannarColor;
  final String pannarTitle, pannerDiscribtion, pannarImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: 335.0,
        height: 406.0,
        decoration: BoxDecoration(
          color: Color(pannarColor),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 24,
              left: 30,
              child: Text(
                pannarTitle,
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              top: 160,
              right: 20,
              width: 300,
              height: 300,
              child: Image.asset(pannarImage),
            ),
            Positioned(
              height: 150,
              width: 300,
              top: 100,
              left: 30,
              child: Text(
                pannerDiscribtion,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
