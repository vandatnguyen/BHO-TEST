import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:finews_module/configs/constants.dart';
import 'package:finews_module/utils/enums.dart';

class BaseCommonWidgets implements _CommonWidgetsInterface {
  @override
  void hideDialog() {
    if (Get.isDialogOpen ?? false) {
      if (Get.overlayContext != null) {
        Navigator.of(Get.overlayContext!).pop();
      } else {
        Get.back();
      }
    }
  }

  @override
  void hideAllDialog({required String pageRoute}) {
    Get.until(ModalRoute.withName(pageRoute));
  }

  @override
  void showProgressingDialog() {
    Get.dialog(
        Material(
          color: Colors.black26,
          child: Center(
            child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: const BoxDecoration(
                    color: Colors.white, borderRadius: BOR_RAD8),
                child: const CircularProgressIndicator()),
          ),
        ),
        barrierDismissible: false,
        useSafeArea: false,
        name: PROGRESSING_DIALOG);
  }

  @override
  void showSnackBar(String message,
      {TdSnackBarType type = TdSnackBarType.error,
      SnackPosition position = SnackPosition.TOP}) {
    Color color;
    Color bgColor;
    String iconPath;
    switch (type) {
      case TdSnackBarType.info:
        color = const Color(0xFF2F80ED);
        bgColor = const Color(0xFFD5E6FB);
        iconPath = "assets/images/svg/ic_sb_info.svg";
        break;
      case TdSnackBarType.success:
        color = const Color(0xFF2EB872);
        bgColor = const Color(0xFFC2F0D9);
        iconPath = "assets/images/svg/ic_sb_success.svg";
        break;
      case TdSnackBarType.error:
        color = const Color(0xFFF46666);
        bgColor = const Color(0xFFFCD1D1);
        iconPath = "assets/images/svg/ic_sb_error.svg";
        break;
      case TdSnackBarType.warning:
        color = const Color(0xFFE6AB3A);
        bgColor = const Color(0xFFFFECC6);
        iconPath = "assets/images/svg/ic_sb_warning.svg";
        break;
    }

    final bar = GetSnackBar(
      messageText: Text(
        message,
        style: TextStyle(
          color: color,
          fontFamily: 'iCielHelveticaNowText',
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),
      icon: SvgPicture.asset(iconPath),
      snackPosition: position,
      backgroundColor: bgColor,
      duration: const Duration(seconds: 3),
      animationDuration: const Duration(milliseconds: 500),
    );

    Get.showSnackbar(bar);
  }

  @override
  void bottomSheet(Widget bottomSheet) {
    Get.bottomSheet(bottomSheet,
        useRootNavigator: true, isScrollControlled: true);
  }

  @override
  void showAlertDialog(
    Widget dialog, {
    bool dismissable = true,
    Function? onCompleted,
    String? name,
  }) {
    Get.dialog(dialog, barrierDismissible: dismissable, name: name)
        .whenComplete(() => onCompleted?.call());
  }
}

abstract class _CommonWidgetsInterface {
  void showProgressingDialog();
  void showSnackBar(String message, {TdSnackBarType type = TdSnackBarType.error});
  void showAlertDialog(Widget dialog,
      {bool dismissable = true, Function onCompleted});
  void bottomSheet(Widget bottomSheet);
  void hideDialog();
  void hideAllDialog({required String pageRoute});
}
