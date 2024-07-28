import 'package:flutter/material.dart';

import '../../screens/tabs_screen.dart';

class Categories extends StatelessWidget {
  const Categories({Key? key}) : super(key: key);

  void press(BuildContext context, Widget? screenName) {
    if (screenName != null) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => screenName));
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {
        "icon": "assets/images/scan.png",
        "text": "Scan",
        "screenName": const TabsScreen(
          atIndex: 1,
        ),
      },
      {
        "icon": "assets/images/book.png",
        "text": "Book",
        "screenName": const TabsScreen(
          atIndex: 2,
        ),
      },
      {
        "icon": "assets/images/tasks.png",
        "text": "challange",
        "screenName": null,
      },
      {
        "icon": "assets/images/records.png",
        "text": "Records",
        "screenName": null,
      },
    ];
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          categories.length,
          (index) => GestureDetector(
            onTap: () => press(context, categories[index]["screenName"]),
            child: CategoryCard(
              icon: categories[index]["icon"],
              text: categories[index]["text"],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  final String? icon, text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 66,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            height: 66,
            width: 66,
            decoration: BoxDecoration(
              color: const Color(0xFFF8F8FA),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.25),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Image.asset(icon!),
          ),
          const SizedBox(height: 5),
          Text(text!,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center)
        ],
      ),
    );
  }
}
