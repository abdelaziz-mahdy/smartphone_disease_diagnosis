import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    Key? key,
    required this.buttonName,
    required this.onTap,
    required this.backgroundColor,
    required this.textColor,
  }) : super(key: key);
  final String buttonName;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: backgroundColor,
        ),
        height: 60,
        width: double.infinity,
        child: TextButton(
            style: ButtonStyle(
                overlayColor: WidgetStateProperty.resolveWith(
              (states) => Colors.white10,
            )),
            onPressed: onTap,
            child: Text(
              buttonName,
              style: TextStyle(
                color: textColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            )));
  }
}
