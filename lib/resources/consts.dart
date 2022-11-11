import 'package:flutter/material.dart';

import './colors.dart';

const freeH = SizedBox(
  width: 20,
);

const freeV = SizedBox(
  height: 20,
);

ThemeData getThemes() {
  return ThemeData(
    iconTheme: const IconThemeData(
      color: white,
      size: 24,
    ),
    appBarTheme: const AppBarTheme(
      color: Colors.transparent,
      elevation: 0,
    ),
    scaffoldBackgroundColor: primary,
    primaryColor: primary,
  );
}
