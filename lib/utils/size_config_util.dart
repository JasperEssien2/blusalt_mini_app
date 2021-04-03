import 'package:flutter/material.dart';

class SizeConfig {
  static late double textSize15;

  SizeConfig._();

  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;

  static late double textSize16;
  static late double textSize30;
  static late double textSize13;
  static late double textSize14;
  static late double textSize12;
  static late double textSize22;

  static late double height100;
  static late double height90;
  static late double heightSize24;

  static late double widthSize25;
  static late double widthSize24;
  static late double widthSize90;

  static late double devicePixelRatio;

  static late double paddingSizeHorizontal12;
  static late double paddingSizeHorizontal20;
  static late double paddingSizeHorizontal25;
  static late double paddingSizeHorizontal32;
  static late double paddingSizeHorizontal5;
  static late double paddingSizeHorizontal16;
  static late double paddingSizeHorizontal8;

  static late double paddingSizeVertical16;
  static late double paddingSizeVertical14;
  static late double paddingSizeVertical12;
  static late double paddingSizeVertical20;
  static late double paddingSizeVertical5;
  static late double paddingSizeVertical8;

  static init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    _initScreenSize();
    _initTextSizes();
    _initWidgetSizes();
    _initPaddingSizes();
  }

  static void _initScreenSize() {
    screenHeight = _mediaQueryData.size.height;
    screenWidth = _mediaQueryData.size.width;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
    devicePixelRatio = _mediaQueryData.devicePixelRatio;
  }

  static void _initTextSizes() {
    textSize12 = calculatePercentageWidth(0.0292);
    textSize16 = calculatePercentageWidth(0.045);
    textSize22 = calculatePercentageWidth(0.054);
    textSize30 = calculatePercentageWidth(0.073);
    textSize14 = calculatePercentageWidth(0.0342);
    textSize15 = calculatePercentageWidth(0.0365);
    textSize13 = calculatePercentageWidth(0.0317);
  }

  static void _initWidgetSizes() {
    height100 = calculatePercentageHeight(0.112);
    height90 = calculatePercentageHeight(0.101);
    heightSize24 = calculatePercentageHeight(0.02675);

    widthSize24 = calculatePercentageWidth(0.059);
    widthSize90 = calculatePercentageWidth(0.219);
    widthSize25 = calculatePercentageWidth(0.061);
  }

  static void _initPaddingSizes() {
    paddingSizeHorizontal12 = calculatePercentageWidth(0.0292);
    paddingSizeHorizontal20 = calculatePercentageWidth(0.05);
    paddingSizeHorizontal25 = calculatePercentageWidth(0.061);
    paddingSizeHorizontal5 = calculatePercentageWidth(0.0122);
    paddingSizeHorizontal8 = calculatePercentageWidth(0.0195);
    paddingSizeHorizontal16 = calculatePercentageWidth(0.04);
    paddingSizeHorizontal32 = calculatePercentageWidth(0.078);

    paddingSizeVertical12 = calculatePercentageHeight(0.0134);
    paddingSizeVertical14 = calculatePercentageHeight(0.0156);
    paddingSizeVertical16 = calculatePercentageHeight(0.0179);
    paddingSizeVertical20 = calculatePercentageHeight(0.0225);
    paddingSizeVertical5 = calculatePercentageHeight(0.0056);
    paddingSizeVertical8 = calculatePercentageHeight(0.009);
  }

  static double calculatePercentageWidth(double value) {
    return screenWidth * value;
  }

  static double calculatePercentageHeight(double value) {
    return screenHeight * value;
  }

  static String toString_() {
    return 'SizeConfig{screenHeight: $screenHeight, screenWidth: $screenWidth, '
        'blockSizeVertical: $blockSizeVertical, '
        'blockSizeHorizontal: $blockSizeHorizontal, '
        'devicePixelRatio: ${_mediaQueryData.devicePixelRatio}, '
        'textScaleFactor: ${_mediaQueryData.textScaleFactor}';
  }
}
