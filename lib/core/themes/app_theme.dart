import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

part 'src/color_theme.dart';

part 'src/font_theme.dart';

class AppTheme {
  // Fonts for implements in our apps.
  static AppFontsTheme font = AppFontsTheme();

  // Colors for implements in our apps.
  static AppColorsTheme color = AppColorsTheme();

  // SIZE
  static const double sizeSS = 8;
  static const double sizeS = 12;
  static const double sizeM = 14;
  static const double sizeL = 18;
  static const double sizeXL = 21; // use for padding edge of screen
  static const double sizeXXL = 24;
  static const double sizeXXXL = 26;

  static const defaultBorderRadius = BorderRadius.all(Radius.circular(sizeSS));

  // Decoration box widget
  static final Decoration decorationWithShadow = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: Colors.grey.shade200),
    boxShadow: [
      BoxShadow(
        color: AppTheme.color.tertiaryColor.withOpacity(0.1),
        spreadRadius: 2,
        blurRadius: 4,
        offset: const Offset(0, 3),
      ),
    ],
  );
}
