import 'package:flutter/material.dart';

class AgeTile extends StatelessWidget {
  final int age;

  const AgeTile({Key? key, required this.age}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        age.toString(),
        style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
      ),
    );
  }
}
