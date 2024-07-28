import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.03),
      width: size.width * 0.8,
      child: const Row(children: [
        Expanded(
          child: Divider(
            color: Colors.grey,
            height: 1.5,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            "OR",
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
          ),
        ),
        Expanded(
          child: Divider(
            color: Colors.grey,
            height: 1.5,
          ),
        ),
      ]),
    );
  }
}
