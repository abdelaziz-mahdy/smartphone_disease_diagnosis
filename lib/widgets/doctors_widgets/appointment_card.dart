import 'package:flutter/material.dart';

class AppointmentCard extends StatelessWidget {
  const AppointmentCard({
    Key? key,
    required this.imageUrl,
    required this.doctorName,
    required this.doctorSpecialty,
    required this.date,
    required this.sessionStart,
    required this.sessionEnd,
  }) : super(key: key);

  final String imageUrl;
  final String doctorName;
  final String doctorSpecialty;
  final String date;
  final String sessionStart;
  final String sessionEnd;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 247, 246, 246),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 85,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 249, 249, 249),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Image.network(
                      imageUrl,
                      height: 70,
                      width: 70,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dr $doctorName',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        doctorSpecialty,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            height: 63,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset("assets/images/calendar_icon.png"),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(date),
                  ],
                ),
                Row(
                  children: [
                    Image.asset("assets/images/chronometer_icon.png"),
                    const SizedBox(
                      width: 10,
                    ),
                    Text("$sessionStart - $sessionEnd"),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
