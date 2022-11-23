import 'package:base_bloc_flutter/constants/constants.dart';
import 'package:flutter/material.dart';

class StyleConstants {
  StyleConstants._();

  static const tinyText = TextStyle(fontSize: 10);
  static const smallText = TextStyle(fontSize: 12);
  static const mediumText = TextStyle(fontSize: 14);
  static const largeText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: ColorConstants.textBlack1,
  );
  static const xLargeText = TextStyle(fontSize: 18);
  static const xxLargeText = TextStyle(fontSize: 20);
  static const xxxLargeText = TextStyle(fontSize: 22);
  static const hugeText = TextStyle(fontSize: 24);
  static const superHugeText = TextStyle(fontSize: 26);
  static const overSizeText = TextStyle(
      fontSize: 32,
      color: ColorConstants.textBlack1,
      fontWeight: FontWeight.w700);
}
