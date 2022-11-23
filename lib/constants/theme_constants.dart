import 'package:flutter/material.dart';

import 'constants.dart';

class ThemeConstants {
  ThemeConstants._();

  static final inputBorder = OutlineInputBorder(
    borderSide: const BorderSide(color: ColorConstants.borderInput),
    borderRadius: BorderRadius.circular(8.0),
  );

  static ThemeData get(BuildContext context) {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        backgroundColor: ColorConstants.white,
        foregroundColor: ColorConstants.primary,
      ),
      primarySwatch: ColorConstants.primaryColorSwatch,
      primaryColor: ColorConstants.primary,
      hintColor: ColorConstants.textBlack3,
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          textStyle: const TextStyle(
            color: ColorConstants.primary,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        // contentPadding:
        // const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        hintStyle: StyleConstants.mediumText.copyWith(
          color: ColorConstants.textBlack3,
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(color: ColorConstants.primary, width: 0.5),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(color: ColorConstants.borderInput, width: 0.5),
          borderRadius: BorderRadius.circular(8),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(color: ColorConstants.borderInput, width: 0.5),
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(color: ColorConstants.errorRed, width: 0.5),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(color: ColorConstants.errorRed, width: 0.5),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 0,
          ),
          onPrimary: ColorConstants.white,
          primary: ColorConstants.primary,
          splashFactory: InkRipple.splashFactory,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            side: BorderSide(
              color: Colors.transparent,
              width: 1,
            ),
          ),
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        checkColor: MaterialStateProperty.all(ColorConstants.white),
        side: const BorderSide(
          color: ColorConstants.primary,
          width: 1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2),
        ),
        fillColor: MaterialStateProperty.all(ColorConstants.primary),
      ),
    );
  }
}
