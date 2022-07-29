import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_color.dart';

///Theme custom cho giao diện sáng mầu
const TEXT_THEME_L = TextTheme(
  headline1: TextStyle(
      fontSize: 32,
      fontFamily: 'iCielHelveticaNowText',
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500),
  headline2: TextStyle(
      fontSize: 28,
      color: INVERTED_BACKGROUND_COLOR_L,
      fontFamily: 'iCielHelveticaNowText',
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w700),

  /// Big and bold Text Style
  headline3: TextStyle(
      color: INVERTED_BACKGROUND_COLOR_L,
      fontFamily: 'iCielHelveticaNowText',
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.normal,
      fontSize: 24.0),

  /// Button Text Style
  headline4: TextStyle(
    color: BACKGROUND_COLOR_L,
    fontFamily: 'iCielHelveticaNowText',
    fontStyle: FontStyle.normal,
    fontSize: 18.0,
    fontWeight: FontWeight.w700,
  ),

  /// App Bar Title
  headline5: TextStyle(
    color: INVERTED_BACKGROUND_COLOR_L,
    fontFamily: 'iCielHelveticaNowText',
    fontStyle: FontStyle.normal,
    fontSize: 18.0,
    fontWeight: FontWeight.w700,
  ),

  /// Dialog Title Style
  headline6: TextStyle(
    color: INVERTED_BACKGROUND_COLOR_L,
    fontFamily: 'iCielHelveticaNowText',
    fontStyle: FontStyle.normal,
    fontSize: 16.0,
    fontWeight: FontWeight.w700,
  ),

  /// Main style
  subtitle1: TextStyle(
    color: INVERTED_BACKGROUND_COLOR_L,
    fontFamily: 'iCielHelveticaNowText',
    fontStyle: FontStyle.normal,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  ),

  subtitle2: TextStyle(
    color: INVERTED_BACKGROUND_COLOR_L,
    fontFamily: 'iCielHelveticaNowText',
    fontStyle: FontStyle.normal,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  ),
  bodyText1: TextStyle(
    color: INVERTED_BACKGROUND_COLOR_L,
    fontSize: 11,
    fontFamily: 'iCielHelveticaNowText',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
  ),
  bodyText2: TextStyle(
    color: INVERTED_BACKGROUND_COLOR_L,
    fontWeight: FontWeight.w400,
    fontSize: 10,
    fontFamily: 'iCielHelveticaNowText',
    fontStyle: FontStyle.normal,
  ),
);

class AppTheme {
  final lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: SCAFFOLD_COLOR,
    primaryColor: PRIMARY_COLOR_L,
    // accentColor: ACCENT_COLOR_L,
    backgroundColor: BACKGROUND_COLOR_L,
    errorColor: ERROR_COLOR_L,
    disabledColor: DISABLE_COLOR_L,
    cardColor: CARD_COLOR_L,
    secondaryHeaderColor: SECONDARY_HEADER_COLOR,
    hintColor: HINT_COLOR,
    splashColor: SPLASH_COLOR,
    buttonTheme: const ButtonThemeData(
      height: 50,
      buttonColor: BUTTON_COLOR_L,
      disabledColor: DISABLE_BUTTON_COLOR_L,
      hoverColor: HOVER_COLOR_L,
      highlightColor: Color(0xFF008E3F),
    ),
    textTheme: TEXT_THEME_L,
    appBarTheme: const AppBarTheme().copyWith(
      shadowColor: SHADOW_COLOR_L,
      color: BACKGROUND_COLOR_L,
      centerTitle: true,
      elevation: 1,
      iconTheme: const IconThemeData(color: INVERTED_BACKGROUND_COLOR_L),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: BACKGROUND_COLOR_L,
      foregroundColor: PRIMARY_COLOR_L,
    ),
    cupertinoOverrideTheme: const CupertinoThemeData(
      primaryColor: PRIMARY_COLOR_L,
    ),
    textSelectionTheme:
        const TextSelectionThemeData(cursorColor: PRIMARY_COLOR_L),
    colorScheme: const ColorScheme.light().copyWith(primary: PRIMARY_COLOR_L),
  );
  final darkTheme = ThemeData.dark();
}

const IS_DARK_MODE = "isDarkMode";

// class AppThemeHelper {
//   final store = GetStorage();

//   ThemeMode getThemeMode() {
//     return isDarkMode() ? ThemeMode.dark : ThemeMode.light;
//   }

//   bool isDarkMode() {
//     return store.read(IS_DARK_MODE) ?? false;
//   }

//   void swapTheme() {
//     bool isDark = isDarkMode();
//     Get.changeThemeMode(isDark ? ThemeMode.light : ThemeMode.dark);
//     store.write(IS_DARK_MODE, !isDark);
//   }
// }
