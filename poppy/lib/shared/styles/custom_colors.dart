import 'package:flutter/material.dart';

class CustomColors {
  static const int _primaryColor = 0xFF3ccc3e;
  static const int _primaryColorLight = 0xFF79FF6f;
  static const int _primaryColorDark = 0xFF009a00;

  static const PRIMARY_COLOR = Color(_primaryColor);
  static const PRIMARY_COLOR_LIGHT = Color(_primaryColorLight);
  static const PRIMARY_COLOR_DARK = Color(_primaryColorDark);
  static const PRIMARY_COLOR_SWATCH = MaterialColor(
    0xFF3ccc3e,
    <int, Color>{
      50: Color(_primaryColorLight),
      100: Color(_primaryColorLight),
      200: Color(_primaryColorLight),
      300: Color(_primaryColorLight),
      400: Color(_primaryColorLight),
      500: Color(_primaryColor),
      600: Color(_primaryColor),
      700: Color(_primaryColorDark),
      800: Color(_primaryColorDark),
      900: Color(_primaryColorDark),
    },
  );
}
