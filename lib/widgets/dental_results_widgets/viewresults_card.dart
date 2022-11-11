import 'package:flutter/material.dart';

class ViewScanDetailsTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function()? press;
  const ViewScanDetailsTile({Key? key, 
    required this.title,
    required this.subtitle,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 90,
        width: 343,
        decoration: BoxDecoration(
            color: const Color(0xff6B779A).withOpacity(0.1),
            borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                )
              ],
            ),
            const Spacer(
              flex: 8,
            ),
            GestureDetector(
              onTap: press,
              child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(13)),
                  child: const Icon(Icons.arrow_forward)),
            ),
          ],
        ),
      ),
    );
  }
}
