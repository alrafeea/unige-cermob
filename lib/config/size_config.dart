import 'package:flutter/cupertino.dart';

import 'config.dart';

class SizeConfig {
  static double _blockWidth = 0;
  static double _blockHeight = 0;

  static double realScreenWidth;
  static double realScreenHeight;
  static double screenWidth;
  static double screenHeight;
  static double textMultiplier;
  static double imageSizeMultiplier;
  static double heightMultiplier;
  static double widthMultiplier;

  static bool isPortrait = true;
  static bool isMobilePortrait = false;
  static bool isMobile = false;

  void init(BoxConstraints constraints, Orientation orientation) {
    realScreenHeight = constraints.maxHeight;
    realScreenWidth = constraints.maxWidth;

    if (constraints.maxWidth <= MAX_SMALL_SCREEN) {
      isMobile = true;
    }
    if (orientation == Orientation.portrait) {
      isPortrait = true;
      if (realScreenWidth < 450) {
        isMobilePortrait = true;
      }
      screenHeight = realScreenHeight;
      screenWidth = realScreenWidth;
    } else {
      isPortrait = false;
      isMobilePortrait = false;
      screenHeight = realScreenWidth;
      screenWidth = realScreenHeight;
    }
    _blockWidth = screenWidth / 100;
    _blockHeight = screenHeight / 100;
    
    textMultiplier = _blockHeight;
    imageSizeMultiplier = _blockWidth;
    heightMultiplier = _blockHeight;
    widthMultiplier = _blockWidth;

    print('realScreenWidth $realScreenWidth');
    print('realScreenHeight $realScreenHeight');
    print('textMultiplier $textMultiplier');
    print('imageSizeMultiplier $imageSizeMultiplier');
    print('heightMultiplier$heightMultiplier');
    print('widthMultiplier $widthMultiplier');
    print('isPortrait $isPortrait');
    print('isMobilePortrait $isMobilePortrait');
  }
}
