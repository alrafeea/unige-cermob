import 'package:flutter/material.dart';

import 'values/values.dart';

class AppTheme {
  static const _lightFillColor = Colors.black;

  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);

  static ThemeData lightThemeData =
  themeData(lightColorScheme, _lightFocusColor);

  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
      colorScheme: colorScheme,
      textTheme: _textTheme,
      iconTheme: IconThemeData(color: AppColors.white),
      canvasColor: colorScheme.background,
      scaffoldBackgroundColor: colorScheme.background,
      highlightColor: Colors.transparent,
      accentColor: colorScheme.primary,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      focusColor: AppColors.primaryColor,
      appBarTheme: AppBarTheme(
        color:Colors.transparent
      ),
      primaryColor: AppColors.primaryColor,
      primaryIconTheme:IconThemeData(color:AppColors.iconColor),
      backgroundColor: Colors.white,
      fontFamily: "Helvetica_Neue_LTStd"
    );
  }

  static const ColorScheme lightColorScheme = ColorScheme(
    primary: Color(0xFF9E1F63),
    primaryVariant: Color(0xFF117378),
    secondary: Color(0xFFEFF3F3),
    secondaryVariant: Color(0xFFFAFBFB),
    background: Color(0xFFF1F2F4),
    surface: Color(0xFFFAFBFB),
    onBackground: Colors.white,
    error: _lightFillColor,
    onError: _lightFillColor,
    onPrimary: _lightFillColor,
    onSecondary: Color(0xFF322942),
    onSurface: Color(0xFF241E30),
    brightness: Brightness.light,
  );

  static const _superBold = FontWeight.w900;
  static const _bold = FontWeight.w700;
  static const _semiBold = FontWeight.w600;
  static const _medium = FontWeight.w500;
  static const _regular = FontWeight.w400;
  static const _light = FontWeight.w300;

  static final TextTheme _textTheme = TextTheme(
    headline1: TextStyle(
      fontSize: Sizes.TEXT_SIZE_96,
      color: AppColors.primaryText,
      fontWeight: _bold,
      fontStyle: FontStyle.normal,
    ),
    headline2: TextStyle(
      fontSize: Sizes.TEXT_SIZE_60,
      color: AppColors.primaryText,
      fontWeight: _bold,
      fontStyle: FontStyle.normal,
    ),
    headline3: TextStyle(
      fontSize: Sizes.TEXT_SIZE_48,
      color: AppColors.primaryText,
      fontWeight: _bold,
      fontStyle: FontStyle.normal,
    ),
    headline4: TextStyle(
      fontSize: Sizes.TEXT_SIZE_34,
      color: AppColors.primaryText,
      fontWeight: _bold,
      fontStyle: FontStyle.normal,
    ),
    headline5: TextStyle(
      fontSize: Sizes.TEXT_SIZE_24,
      color: AppColors.primaryText,
      fontWeight: _bold,
      fontStyle: FontStyle.normal,
    ),
    headline6: TextStyle(
      fontSize: Sizes.TEXT_SIZE_20,
      color: AppColors.primaryText,
      fontWeight: _bold,
      fontStyle: FontStyle.normal,
    ),
    subtitle1: TextStyle(
      fontSize: Sizes.TEXT_SIZE_16,
      color: AppColors.primaryText,
      fontWeight: _semiBold,
      fontStyle: FontStyle.normal,
    ),
    subtitle2: TextStyle(
      fontSize: Sizes.TEXT_SIZE_14,
      color: AppColors.primaryText,
      fontWeight: _semiBold,
      fontStyle: FontStyle.normal,
    ),
    bodyText1: TextStyle(
      fontSize: Sizes.TEXT_SIZE_16,
      color: AppColors.primaryText,
      fontWeight: _light,
      fontStyle: FontStyle.normal,
    ),
    bodyText2: TextStyle(
      fontSize: Sizes.TEXT_SIZE_14,
      color: AppColors.primaryText,
      fontWeight: _light,
      fontStyle: FontStyle.normal,
    ),
    button: TextStyle(
      fontSize: Sizes.TEXT_SIZE_14,
      color: AppColors.primaryText,
      fontStyle: FontStyle.normal,
      fontWeight: _medium,
    ),
    caption: TextStyle(
      fontSize: Sizes.TEXT_SIZE_12,
      color: AppColors.white,
      fontWeight: _regular,
      fontStyle: FontStyle.normal,
    ),
  );
}
