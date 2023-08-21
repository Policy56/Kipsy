import 'package:flutter/material.dart';

class TextManager {
  static TextTheme get textStyle => //GoogleFonts.comfortaaTextTheme();

      const TextTheme(
        displayLarge: TextStyle(
          fontSize: 19,
          height: 1,
          fontWeight: FontWeight.w600,
        ),
        displayMedium: TextStyle(
          fontSize: 17,
          height: 1.4,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          height: 1.3,
          fontWeight: FontWeight.w600,
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          height: 1.45,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: TextStyle(
          fontSize: 15,
          height: 1.4,
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          height: 1.4,
          fontWeight: FontWeight.w400,
        ),
        labelSmall: TextStyle(
          fontSize: 11,
          height: 1.4,
          fontWeight: FontWeight.w400,
        ),
      );
}
