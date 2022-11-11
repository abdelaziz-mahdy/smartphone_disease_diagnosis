import 'package:flutter/material.dart';

class GenderIcon extends StatelessWidget {
  const GenderIcon(
      {Key? key,
      required this.icon,
      required this.label,
      required this.press,
      required this.color})
      : super(key: key);
  final IconData icon;
  final String label;
  final VoidCallback press;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.35,
        width: MediaQuery.of(context).size.width * 0.4,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(16)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              label,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Icon(
              icon,
              size: 95,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
