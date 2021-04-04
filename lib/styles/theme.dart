import 'package:blusalt_mini_app/utils/size_config_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart' as colors;

ThemeData appTheme(BuildContext context, bool isDarkMode) {
  SizeConfig.init(context);
  return ThemeData(
    primaryColor: colors.appbarEndGradient,
    accentColor: colors.accentColor,
    scaffoldBackgroundColor:
        isDarkMode ? colors.appBackgroundColorDark : colors.appBackgroundColor,
    cardColor: isDarkMode ? colors.cardColorDark : colors.cardColor,

    appBarTheme: AppBarTheme(
      color: isDarkMode
          ? colors.appBackgroundColorDark
          : colors.appBackgroundColor,
      elevation: 0.0,
      actionsIconTheme: IconThemeData(
          color: isDarkMode ? colors.appLightGreyDark : colors.appLightGrey,
          size: 24.0),
      iconTheme: IconThemeData(
          color: isDarkMode ? colors.appLightGreyDark : colors.appLightGrey,
          size: 24.0),
      // : IconThemeData(color: colors.accentLightColor, size: 24.0),
      textTheme: _textTheme(false, context),
    ),
    accentIconTheme: IconThemeData(color: colors.accentColorLight, size: 24.0),
    textTheme: _textTheme(false, context),
    accentTextTheme: _textTheme(true, context),
    buttonTheme: ButtonThemeData(
      buttonColor: colors.accentColorLight,
      disabledColor: Colors.grey,
    ),
    toggleButtonsTheme: ToggleButtonsThemeData(),
    // fontFamily: "Proxima",
    bottomSheetTheme:
        BottomSheetThemeData(backgroundColor: Colors.black.withOpacity(0)),
  );
}

TextTheme _textTheme(bool isAccentColor, BuildContext context) {
  var color2 = isAccentColor
      ? colors.accentColor
      : Theme.of(context).colorScheme.primaryTextColorScheme;
  return TextTheme(
    headline6: GoogleFonts.montserrat(
      textStyle: TextStyle(
        color: color2,
        fontSize: SizeConfig.textSize22,
        fontWeight: FontWeight.w600,
      ),
    ),
    bodyText1: GoogleFonts.montserrat(
      textStyle: TextStyle(
        color: color2,
        fontSize: SizeConfig.textSize16,
        fontWeight: FontWeight.w400,
      ),
    ),
    bodyText2: GoogleFonts.montserrat(
      textStyle: TextStyle(
        color: color2,
        fontSize: SizeConfig.textSize14,
        fontWeight: FontWeight.w400,
      ),
    ),
    caption: GoogleFonts.montserrat(
      textStyle: TextStyle(
        color: color2,
        fontSize: SizeConfig.textSize12,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}
