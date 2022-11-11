import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:horizontal_picker/horizontal_picker.dart';

import '../models/search_filters_model.dart';
import '../state/doctors_state_management.dart';

class FiltersWidget extends StatefulWidget {
  static const categoryNames = ['All', 'Dermatology', 'Dentistry'];
  const FiltersWidget({Key? key}) : super(key: key);

  @override
  State<FiltersWidget> createState() => _FiltersWidgetState();
}

class _FiltersWidgetState extends State<FiltersWidget> {
  int _categoryValue = 1;
  int _cityValue = 1;
  int _priceValue = 1;
  int _starRating = 0;
  int _yearsValue = 0;

  var cityNames = ['any', 'Cairo', 'Giza'];
  var categoryNames = ['all', 'Dermatology', 'Dentistry'];

  var mappedPrices = [
    {'priceLow': 0, 'priceHigh': null},
    {'priceLow': 0, 'priceHigh': 100},
    {'priceLow': 100, 'priceHigh': 200},
    {'priceLow': 200, 'priceHigh': 300},
    {'priceLow': 300, 'priceHigh': 400},
    {'priceLow': 400, 'priceHigh': 500},
    {'priceLow': 500, 'priceHigh': null},
  ];
  Widget cityCustomRadioButton(String text, int index) {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          _cityValue = index;
        });
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
            (_cityValue == index) ? const Color.fromARGB(255, 127, 164, 248) : Colors.white),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        side: MaterialStateProperty.all(const BorderSide(color: Color.fromARGB(255, 127, 164, 248))),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: (_cityValue == index) ? Colors.white : const Color.fromARGB(255, 127, 164, 248),
        ),
      ),
    );
  }

  Widget categoryCustomRadioButton(String text, int index) {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          _categoryValue = index;
        });
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
            (_categoryValue == index) ? const Color.fromARGB(255, 127, 164, 248) : Colors.white),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        side: MaterialStateProperty.all(const BorderSide(color: Color.fromARGB(255, 127, 164, 248))),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: (_categoryValue == index) ? Colors.white : const Color.fromARGB(255, 127, 164, 248),
        ),
      ),
    );
  }

  Widget priceCustomRadioButton(String text, int index) {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          _priceValue = index;
        });
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
            (_priceValue == index) ? const Color.fromARGB(255, 127, 164, 248) : Colors.white),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        side: MaterialStateProperty.all(const BorderSide(color: Color.fromARGB(255, 127, 164, 248))),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: (_priceValue == index) ? Colors.white : const Color.fromARGB(255, 127, 164, 248),
        ),
      ),
    );
  }

  Widget headerTextWidget(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Stack(
        children: [
          Positioned(
            left: deviceSize.width * 0.25,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Container(
                height: 3,
                width: deviceSize.width * 0.4,
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                headerTextWidget('City'),
                Wrap(
                  spacing: 10,
                  runSpacing: 5,
                  children: [
                    cityCustomRadioButton("Any", 1),
                    cityCustomRadioButton("Cairo", 2),
                    cityCustomRadioButton("Giza", 3),
                  ],
                ),
                headerTextWidget('Category'),
                Wrap(
                  spacing: 10,
                  runSpacing: 5,
                  children: [
                    categoryCustomRadioButton("All", 1),
                    categoryCustomRadioButton("Dermatology", 2),
                    categoryCustomRadioButton("Dentistry", 3),
                  ],
                ),
                headerTextWidget('Price'),
                Wrap(
                  spacing: 10,
                  runSpacing: 5,
                  children: [
                    priceCustomRadioButton("All", 1),
                    priceCustomRadioButton("50-100", 2),
                    priceCustomRadioButton("100-200", 3),
                    priceCustomRadioButton("200-300", 4),
                    priceCustomRadioButton("300-400", 5),
                    priceCustomRadioButton("400-500", 6),
                    priceCustomRadioButton("500+", 7),
                  ],
                ),
                headerTextWidget('Years of Experience'),
                HorizontalPicker(
                  initialPosition: InitialPosition.start,
                  minValue: 0,
                  maxValue: 10,
                  divisions: 10,
                  height: 80,
                  onChanged: (value) {
                    setState(() {
                      _yearsValue = value.round();
                    });
                  },
                ),
                headerTextWidget('Average Rating'),
                Row(
                  children: List.generate(5, (index) {
                    return IconButton(
                      onPressed: () => setState(() {
                        _starRating = index;
                      }),
                      icon: index <= _starRating
                          ? const Icon(
                              Icons.star_rounded,
                              color: Color.fromARGB(255, 255, 196, 59),
                              size: 30,
                            )
                          : const Icon(
                              Icons.star_outline_rounded,
                              color: Color.fromARGB(255, 255, 196, 59),
                              size: 30,
                            ),
                    );
                  }),
                ),
                const SizedBox(
                  height: 4,
                ),
                Consumer(
                  builder: (context, ref, child) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: OutlinedButton(
                          onPressed: () {
                            ref.read(filtersProvider.notifier).state =
                                FiltersModel();
                            Navigator.of(context).pop();
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            side: MaterialStateProperty.all(
                                BorderSide(color: Colors.redAccent[100]!)),
                          ),
                          child: Text(
                            'Reset',
                            style: TextStyle(
                              color: Colors.redAccent[100],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: ElevatedButton(
                          onPressed: () {
                            ref.read(filtersProvider.notifier).state =
                                FiltersModel(
                              specialty: categoryNames[_categoryValue - 1],
                              city: cityNames[_cityValue - 1],
                              rating: _starRating == 0 ? _starRating : _starRating + 1,
                              yearsOfExperience: _yearsValue,
                              priceLow: mappedPrices[_priceValue - 1]['priceLow'] as int,
                              priceHigh: mappedPrices[_priceValue - 1]['priceHigh'],
                            );
                            Navigator.of(context).pop();
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(const Color.fromARGB(255, 127, 164, 248)),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          child: const Text('Apply'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
