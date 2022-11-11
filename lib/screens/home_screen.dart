import 'package:flutter/material.dart';

import '../widgets/home_widgets/home_horizontal_list.dart';
import '../widgets/home_widgets/home_categories.dart';
import '../widgets/home_widgets/home_records.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 15),
          physics: const BouncingScrollPhysics(),
          children: const [
            SizedBox(
                height: 400,
                child: HomeHorizontalWidget(
                    pannarTitle: "SUNO",
                    pannerDiscribtion:
                        "Introducing our medical application where AI meets medicine",
                    pannarImage: './assets/images/Doctorsmain.png',
                    pannarColor: 0xFF7FA3F8)),
            SizedBox(
              height: 15,
            ),
            Text(
              'Services',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Categories(),
            SizedBox(
              height: 15,
            ),
            RecordsTile(),
          ],
        );
  }
}
