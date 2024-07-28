import 'package:flutter/material.dart';

import '../../screens/tabs_screen.dart';

class RecordsTile extends StatelessWidget {
  const RecordsTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const TabsScreen(
                      atIndex: 3,
                    )));
      },
      child: Container(
        height: 75,
        decoration: BoxDecoration(
            color: const Color(0xff6B779A).withOpacity(0.1),
            borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: Row(
          children: <Widget>[
            const SizedBox(
              width: 17,
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "View Your Appointments",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Find all your bookings here",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                )
              ],
            ),
            const Spacer(),
            Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 9),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(13)),
                child: const Icon(Icons.arrow_forward)),
          ],
        ),
      ),
    );
  }
}
