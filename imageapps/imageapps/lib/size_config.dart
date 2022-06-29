import 'package:flutter/material.dart';

// Responsive Design
class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? blocksSizeH;
  static double? blocksSizeV;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
    blocksSizeH = screenWidth! / 100;
    blocksSizeV = screenHeight! / 100;
  }
}
