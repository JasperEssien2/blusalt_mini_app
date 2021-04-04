import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

const Color accentColor = Color(0xFF6078EA);
Color accentColorLight = Color(0xFF6078EA).withOpacity(0.3);

const Color appbarEndGradient = Color(0xFF6078EA);
const Color appbarStartGradient = Color(0xFF17EAD9);

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
  Color get primaryTextColorScheme {
    return SchedulerBinding.instance!.window.platformBrightness ==
            Brightness.light
        ? primaryText
        : primaryTextDark;
  }

  Color get secondaryTextColorScheme {
    return SchedulerBinding.instance!.window.platformBrightness ==
            Brightness.light
        ? secondaryText
        : secondaryTextDark;
  }

  Color get dividerColorScheme =>
      SchedulerBinding.instance!.window.platformBrightness == Brightness.light
          ? appDivider
          : appDividerDark;
}
