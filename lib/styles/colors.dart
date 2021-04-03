import 'package:flutter/material.dart';

const Color accentColor = Color(0xFFE88D72);
Color accentColorLight = Color(0xFFE88D72).withOpacity(0.3);

const Color appbarEndGradient = Color(0xFF543855);
const Color appbarStartGradient = Color(0xFFE88D72);

const Color appLightGrey = Color(0xFFBDBDBD);
const Color appDivider = Color(0xFFBDBDBD);
const Color appBackgroundColor = Colors.white;
const Color cardColor = Colors.white;
const Color primaryText = Color(0xFF323F4B);
const Color secondaryText = Color(0xFF7B8794);

const Color appBackgroundColorDark = Color(0xff121212);
const Color appDividerDark = Color(0xFFBDBDBD);
const Color cardColorDark = Color(0xff404040);
const Color primaryTextDark = Color(0xFFffffff);
const Color secondaryTextDark = Color(0xFFb3b3b3);
const Color appLightGreyDark = Color(0xff404040);

extension ColorSchemeX on ColorScheme {
  Color get primaryTextColorScheme =>
      brightness == Brightness.light ? primaryText : primaryTextDark;

  Color get secondaryTextColorScheme =>
      brightness == Brightness.light ? secondaryText : secondaryTextDark;

  Color get dividerColorScheme =>
      brightness == Brightness.light ? appDivider : appDividerDark;
}
