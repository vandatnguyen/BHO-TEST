import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' hide TextDirection;

extension DurationExtension on Duration {
  String formatHHMMSS() {
    return '$this'.split('.')[0].padLeft(8, '0');
  }

  String formatMMSS() {
    final p = '$this'.split('.')[0].padLeft(8, '0').split(':');
    return "${p[1]}:${p[2]}";
  }
}

extension StringNullSafetyExtension on String? {
  bool get hasText => this != null && this!.isNotEmpty;

  String? capitalize() {
    return this ?? "${this![0].toUpperCase()}${this!.substring(1)}";
  }

  int numOfLine({
    required TextStyle style,
    required double maxWidth,
    TextDirection? textDirection = TextDirection.rtl,
  }) {
    if (this == null && this!.isEmpty) return 0;
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: this, style: style),
      textDirection: TextDirection.rtl,
    )..layout();
    textPainter.layout(maxWidth: maxWidth);

    final TextSelection selection =
        TextSelection(baseOffset: 0, extentOffset: this!.length);
    final List<TextBox> boxes = textPainter.getBoxesForSelection(selection);
    int numberOfLines = 0;
    double currentTop = 0;
    for (int i = 0; i < boxes.length; i++) {
      if (currentTop != boxes[i].top) {
        numberOfLines += 1;
        currentTop = boxes[i].top;
      }
    }
    return numberOfLines;
  }

  Size textSize({
    required TextStyle style,
    TextDirection? textDirection = TextDirection.rtl,
  }) {
    if (this == null && this!.isEmpty) return Size.zero;
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: this, style: style),
      maxLines: 1,
      textDirection: textDirection,
    )..layout();
    return textPainter.size;
  }
}

extension CustomStringExtension on String {
  static const diacritics =
      'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž';
  static const nonDiacritics =
      'AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz';
  static const diacriticsReg =
      'à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ|À|Á|Ạ|Ả|Ã|Â|Ầ|Ấ|Ậ|Ẩ|Ẫ|Ă|Ằ|Ắ|Ặ|Ẳ|Ẵ|è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ|È|É|Ẹ|Ẻ|Ẽ|Ê|Ề|Ế|Ệ|Ể|Ễ|ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ|Ò|Ó|Ọ|Ỏ|Õ|Ô|Ồ|Ố|Ộ|Ổ|Ỗ|Ơ|Ờ|Ớ|Ợ|Ở|Ỡ|ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ|Ù|Ú|Ụ|Ủ|Ũ|Ư|Ừ|Ứ|Ự|Ử|Ữ|ì|í|ị|ỉ|ĩ|Ì|Í|Ị|Ỉ|Ĩ|đ|Đ|ỳ|ý|ỵ|ỷ|ỹ|Ỳ|Ý|Ỵ|Ỷ|Ỹ';

  bool get containDiacritics => contains(RegExp(diacriticsReg));

  String get withoutDiacriticalMarks => splitMapJoin('',
      onNonMatch: (char) => char.isNotEmpty && diacritics.contains(char)
          ? nonDiacritics[diacritics.indexOf(char)]
          : char);

  String nonAccentVietnamese() {
    var str = this;
    str = str.toLowerCase();
    str = str.replaceAll(RegExp('à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ'), "a");
    str = str.replaceAll(RegExp('è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ'), "e");
    str = str.replaceAll(RegExp('ì|í|ị|ỉ|ĩ'), "i");
    str = str.replaceAll(RegExp('ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ'), "o");
    str = str.replaceAll(RegExp('ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ'), "u");
    str = str.replaceAll(RegExp('ỳ|ý|ỵ|ỷ|ỹ'), "y");
    str = str.replaceAll(RegExp('đ'), "d");
    str = str.replaceAll(RegExp(r'\u0300|\u0301|\u0303|\u0309|\u0323'),
        ""); // Huyền sắc hỏi ngã nặng
    str = str.replaceAll(RegExp(r'\u02C6|\u0306|\u031B'), ""); // Â, Ê, Ă, Ơ, Ư
    return str;
  }

  bool isValidPassLength() {
    return RegExp(r'^.{8,999}$').hasMatch(this);
  }

  bool isEmailWith(String regex) {
    return RegExp(regex).hasMatch(this);
  }

  bool isValidCharacter() {
    return RegExp('.*(^(.*([A-Z]).*([a-z]))|(([a-z]).*([A-Z]))).*')
        .hasMatch(this);
  }

  bool isValidAz() {
    return RegExp('.*[^A-Za-z].*').hasMatch(this);
  }

  bool isPhoneNumberWith(String reg) {
    final fullReg = "^(($reg)+[0-9]{7})\$";
    return RegExp(fullReg).hasMatch(this);
  }

  bool isValidPassword() {
    return RegExp(r"^(?=.*[A-Za-z])(?=.*\d).{6,20}$").hasMatch(this);
  }

  String convertToPhone() {
    var res = this;
    if (startsWith("84")) {
      res = "0${res.substring(2)}";
    }
    res = res.replaceAll('+84', '0');
    res = res.replaceAll(RegExp("[^\\d]"), "");
    return res;
  }

  int hexToInt() {
    var hexColor = toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  String phoneWithDialCode(String dialCode) {
    var removeSpace = replaceAll(' ', '');
    if (dialCode == "+84") {
      if (removeSpace.startsWith("0")) removeSpace = removeSpace.substring(1);
      var subString = "";
      for (int i = 1; i <= removeSpace.length; i++) {
        if (i % 3 == 0) {
          subString += " ${removeSpace.substring(i - 3, i)}";
        }
      }
      return "($dialCode) $subString";
    } else {
      return "($dialCode) $removeSpace";
    }
  }

  String capitalize() {
    if (isEmpty) return "";
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

extension CustomIntExtension on int {
  String toCurrency({String symbol = "đ"}) {
    final oCcy = NumberFormat.decimalPattern("vi");
    return "${oCcy.format(this)}$symbol";
  }

  DateTime millisecondsToDateTime() {
    return DateTime.fromMillisecondsSinceEpoch(this);
  }
}

extension CustomNumExtension on num {
  String toCurrency({String symbol = "đ"}) {
    final oCcy = NumberFormat.decimalPattern("vi");
    return "${oCcy.format(this)}$symbol";
  }

  num floorWithFractionDigits(int fractionDigits) {
    final p = pow(10, fractionDigits);
    return (this * p).floor() / p;
  }

  String formatWithSeparator({String separator = ","}) {
    return toString().replaceAll(RegExp(r'\.'), separator);
  }
}

extension CustomDoubleExtension on double {
  String toCurrency({String symbol = "đ"}) {
    final oCcy = NumberFormat.decimalPattern("vi");
    return "${oCcy.format(this)}$symbol";
  }
}

extension BuildContextExtension on BuildContext {
  //Color
  Color get scaffoldBackgroundColor => Theme.of(this).scaffoldBackgroundColor;

  Color get primaryColor => Theme.of(this).primaryColor;

  // Color get accentColor => Theme.of(this).accentColor;
  Color get backgroundColor => Theme.of(this).backgroundColor;

  Color get errorColor => Theme.of(this).errorColor;

  Color get disabledColor => Theme.of(this).disabledColor;

  Color get shadowColor => Theme.of(this).shadowColor;

  Color get indicatorColor => Theme.of(this).indicatorColor;

  Color get secondaryHeaderColor => Theme.of(this).secondaryHeaderColor;

  //TextStyle
  TextStyle get textSize32 => Theme.of(this).textTheme.headline1!;

  TextStyle get textSize28 => Theme.of(this).textTheme.headline2!;

  TextStyle get textSize24 => Theme.of(this).textTheme.headline3!;

  TextStyle get textSize20 =>
      const TextStyle(fontSize: 20, fontFamily: 'iCielHelveticaNowText');

  TextStyle get textSize18light => Theme.of(this).textTheme.headline4!;

  TextStyle get textSize18 => Theme.of(this).textTheme.headline5!;

  TextStyle get textSize16 => Theme.of(this).textTheme.headline6!;

  TextStyle get textSize14 => Theme.of(this).textTheme.subtitle1!;

  TextStyle get textSize12 => Theme.of(this).textTheme.subtitle2!;

  TextStyle get textSize11 => Theme.of(this).textTheme.bodyText1!;

  TextStyle get textSize10 => Theme.of(this).textTheme.bodyText2!;

  //MediaQuery
  Size get screenSize => MediaQuery.of(this).size;

  EdgeInsets get viewPadding => MediaQuery.of(this).viewPadding;

  EdgeInsets get viewInsets => MediaQuery.of(this).viewInsets;

  bool get isSmallScene => MediaQuery.of(this).size.width <= 340;
}
