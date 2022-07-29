import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/dialog/dialog_route.dart';
import 'package:finews_module/configs/constants.dart';
import 'package:finews_module/cores/networking/result.dart';
import 'package:finews_module/cores/states/base_common_widget.dart';
// import 'package:finews_module/data/entities/data_input_app.dart';
// import 'package:finews_module/pages/homePage/controller/home_page_controller.dart';
// import 'package:finews_module/pages/main_provider.dart';
import 'package:finews_module/routes/app_routes.dart';
// import 'package:finews_module/shared_widgets/CustomAlertDialog.dart';

abstract class BaseController extends GetxController
    with _ScaffoldInterface, BaseCommonWidgets {
  // MainTradingProvider get mainProvider => Get.find<MainTradingProvider>();
  //
  // DataInputApp get dataAppParent => mainProvider.dataInputApp;
  //
  // Future handleErrorResponse(Errors? errors) async {
  //   final hasInternet = await mainProvider.hasConnectInternet();
  //   if (hasInternet && errors != null) {
  //     showAlertDialog(CustomAlertDialog(
  //         title: "Thông báo",
  //         desc: errors.message,
  //         actions: [
  //           AlertAction(
  //               text: "cancel".tr,
  //               onPressed: () {
  //                 hideDialog();
  //               }),
  //         ]));
  //   }else if (!hasInternet) {
  //     showAlertDialog(CustomAlertDialog(
  //         title: "Lỗi kết nối",
  //         desc: "Vui lòng kiểm tra lại internet hoặc thử lại sau.",
  //         actions: [
  //           AlertAction(
  //               text: "cancel".tr,
  //               onPressed: () {
  //                 hideDialog();
  //               }),
  //         ]));
  //   }
  // }

  bool isLogged() {
    return true;
  }

  void refreshAccountInfo(){
    // Get.find<HomePageController>().getAccountInfo();
  }

  void requestLogin() {}

  Future<void> loginFaceBook() async {}

  void loginGoogle() {}

  Future handleLoginFacebook() async {}

  Future<void> loginBackend(String token) async {}

  void saveDataLocal() {}

  @override
  Future<bool> onWillPop() {
    return Future.value(true);
  }

  @override
  void hideKeyboard() {
    if (kDebugMode) log("hideKeyboard");
    Get.focusScope?.unfocus();
  }

  // void backToHome({int selectTab = 0}) {
  //   Get.until(ModalRoute.withName(AppRoutes.mainView));
  //   Get.find<HomePageController>().selTab(selectTab);
  // }

  bool _shouldShowDialog(String? dialogName) {
    if (!(Get.isDialogOpen ?? false)) return true;
    final route = Get.rawRoute;
    if (dialogName != null && route is GetDialogRoute) {
      return route.settings.name != dialogName &&
          route.settings.name != "NetworkError";
    }
    return true;
  }

  void showMessageDialog(Widget dialog,
      {String? name, bool canDissmiss = true}) {
    if (_shouldShowDialog(name)) {
      if (Get.isDialogOpen ?? false) {
        Get.back();
        DUR_250.delay().then((value) =>
            Get.dialog<Result>(dialog, barrierDismissible: canDissmiss));
      } else {
        Get.dialog<Result>(dialog, barrierDismissible: canDissmiss, name: name);
      }
    }
  }
}

abstract class _CommonWidgetsInterface {
  void showProgressingDialog();

  void showSnackBar(String message);

  void showAlertDialog(Widget dialog,
      {bool dismissable = true, Function onCompleted});

  void bottomSheet(Widget bottomSheet);

  void hideDialog();

  void showDialogPickImage();
}

abstract class _ScaffoldInterface {
  Future<bool> onWillPop();

  void hideKeyboard();
}


