import 'package:flutter/material.dart';
import 'colors.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.defaultColor,
      primaryColor: AppColors.primaryColor,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: AppColors.secondaryColor,
      ),
      textTheme: const TextTheme(
        // Define your text styles, if needed
      ),
      // You can also customize other theme aspects like appBarTheme, buttonTheme, etc.
    );
  }

// Optionally, define a darkTheme if your app supports dark mode
}
