// import 'dart:async';
// import 'dart:convert';
// import 'dart:developer';
//
// import 'package:crypto/crypto.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_navigation/src/dialog/dialog_route.dart';
// import 'package:finews_module/configs/constants.dart';
// import 'package:finews_module/cores/networking/result.dart';
// import 'package:finews_module/pages/main_provider.dart';
// import 'package:finews_module/routes/app_routes.dart';
// import 'package:finews_module/shared_widgets/CustomAlertDialog.dart';
// import 'package:finews_module/trading_module.dart';
// import 'package:finews_module/utils/extensions.dart';
//
// enum Method { GET, POST, DELETE }
//
// class Api extends GetConnect {
//   final String backendUrl;
//   String fullToken;
//   final String userId;
//
//   Api(
//       {required this.backendUrl,
//       required this.fullToken,
//       required this.userId});
//
//   @override
//   String get baseUrl => backendUrl;
//
//   String get authorization => fullToken;
//
//   String generateMd5(String input) {
//     return md5.convert(utf8.encode(input)).toString();
//   }
//
//   @override
//   void onInit() {
//     httpClient.timeout = AppConstants.TIME_OUT;
//     final mainProvider = GetInstance().find<MainTradingProvider>();
//     // print("addRequestModifier");
//     httpClient.addRequestModifier<void>((request) async {
//       request.headers["Parent-App"] = "TIKOP";
//       request.headers["Lang"] = "vi";
//       request.headers["App-Ver"] = mainProvider.appVersion;
//       request.headers["Trading-Ver"] = mainProvider.appTradingVersion;
//       request.headers["Device-ID"] = mainProvider.deviceId;
//       request.headers['Authorization'] = mainProvider.accessToken ?? "";
//       request.headers['X-Request-ID'] = generateMd5(
//           "$userId${DateTime.now().millisecond.toString()}${100.genRandom()}");
//       if (kDebugMode) {
//         log(request.headers.toString(), name: request.url.path);
//       }
//       return request;
//     });
//     super.onInit();
//   }
//
//   String endPointLogin = "on-boarding/v1/login";
//
//   /// FOR NETWORKING WITH THE [Method.GET]
//   /// RETURN DATA WITH [Result] MODEL
//   Future<Result> getData({
//     required String endPoint,
//     Map<String, dynamic>? params,
//     required Duration timeOut,
//   }) async {
//     // onInit();
//     Response? res;
//     try {
//       res = await get(endPoint, query: params).timeout(timeOut);
//
//       if (res.isOk) {
//         _requestOk(Method.GET, endPoint, params, res.bodyString);
//       } else {
//         _requestException(
//           Method.GET,
//           endPoint,
//           "PARSING ERROR",
//           params: params,
//           bodyString: res.bodyString,
//         );
//       }
//       final rs = Result.fromJson(res.bodyString!);
//       final handlerResponse = await handlerResult(rs, endPoint: endPoint);
//       if (handlerResponse.code == 401 &&
//           !(handlerResponse.tikopException ?? false)) {
//         //token trading het han
//         await onSessionTimeout(rs);
//         return rs;
//       } else if (handlerResponse.code == 401 &&
//           (handlerResponse.tikopException ?? false)) {
//         //token tikop het han
//         await onSessionTimeout(rs);
//         return rs;
//       }
//       return handlerResponse;
//     } on TimeoutException catch (e) {
//       _requestException(
//         Method.GET,
//         endPoint,
//         "TimeOut",
//         params: params,
//         bodyString: res?.bodyString,
//         exception: e.message,
//       );
//       return onTimeOut(endPoint: endPoint, params: params);
//     } catch (e) {
//       _requestException(
//         Method.GET,
//         endPoint,
//         "ERROR",
//         params: params,
//         bodyString: res?.bodyString,
//         exception: e.toString(),
//       );
//       return onServerError(endPoint: endPoint, params: params);
//     }
//   }
//
//   /// FOR NETWORKING WITH [Method.POST]
//   /// RETURN DATA WITH [Result] MODEL
//   Future<Result> postData({
//     required String endPoint,
//     dynamic params,
//     required Duration timeOut,
//   }) async {
//     // onInit();
//     Response? res;
//     try {
//       if (params == null) {
//         res = await httpClient.post(endPoint).timeout(timeOut);
//       } else {
//         res = await httpClient.post(endPoint, body: params).timeout(timeOut);
//         log("body:\n${res.body}");
//       }
//
//       if (res.isOk) {
//         _requestOk(Method.POST, endPoint, params, res.bodyString);
//       } else {
//         _requestException(
//           Method.POST,
//           endPoint,
//           "PARSING ERROR",
//           params: params,
//           bodyString: res.bodyString,
//         );
//       }
//       final rs = Result.fromJson(res.bodyString!);
//       final handlerResponse = await handlerResult(rs, endPoint: endPoint);
//       if (handlerResponse.code == 401 &&
//           !(handlerResponse.tikopException ?? false)) {
//         await onSessionTimeout(rs);
//         return rs;
//       } else if (handlerResponse.code == 401 &&
//           (handlerResponse.tikopException ?? false)) {
//         await onSessionTimeout(rs);
//         return rs;
//       }
//       return handlerResponse;
//
//       // return handlerResult(Result.fromJson(res.bodyString ?? ""),
//       //     endPoint: endPoint);
//     } on TimeoutException catch (e) {
//       _requestException(
//         Method.POST,
//         endPoint,
//         "TimeOut",
//         params: params,
//         bodyString: res?.bodyString,
//         exception: e.message,
//       );
//       return onTimeOut(endPoint: endPoint, params: params);
//     } catch (e) {
//       _requestException(
//         Method.POST,
//         endPoint,
//         "ERROR",
//         params: params,
//         bodyString: res?.bodyString,
//         exception: e.toString(),
//       );
//       return onServerError(endPoint: endPoint, params: params);
//     }
//   }
//
//   /// FOR NETWORKING WITH [Method.DELETE]
//   /// RETURN DATA WITH [Result] MODEL
//   Future<Result> deleteData({
//     required String endPoint,
//     required Duration timeOut,
//     Map<String, dynamic>? params,
//   }) async {
//     // onInit();
//
//     Response? res;
//     try {
//       res = await delete(endPoint, query: params).timeout(timeOut);
//       if (res.isOk) {
//         _requestOk(Method.DELETE, endPoint, params, res.bodyString);
//       } else {
//         _requestException(
//           Method.POST,
//           endPoint,
//           "PARSING ERROR",
//           params: params,
//           bodyString: res.bodyString,
//         );
//       }
//       final rs = Result.fromJson(res.bodyString!);
//
//       final handlerResponse = await handlerResult(rs, endPoint: endPoint);
//       if (handlerResponse.code == 401 &&
//           !(handlerResponse.tikopException ?? false)) {
//         await onSessionTimeout(rs);
//         return rs;
//       } else if (handlerResponse.code == 401 &&
//           (handlerResponse.tikopException ?? false)) {
//         await onSessionTimeout(rs);
//         return rs;
//       }
//       return handlerResponse;
//       // return handlerResult(Result.fromJson(res.bodyString!),
//       //     endPoint: endPoint);
//     } on TimeoutException catch (e) {
//       _requestException(
//         Method.DELETE,
//         endPoint,
//         "TimeOut",
//         params: params,
//         bodyString: res?.bodyString,
//         exception: e.message,
//       );
//       return onTimeOut(endPoint: endPoint, params: params);
//     } catch (e) {
//       _requestException(
//         Method.DELETE,
//         endPoint,
//         "ERROR",
//         params: params,
//         bodyString: res?.bodyString,
//         exception: e.toString(),
//       );
//       return onServerError(endPoint: endPoint, params: params);
//     }
//   }
//
//   _requestException(
//     Method method,
//     String endPoint,
//     String status, {
//     String? exception,
//     String? bodyString,
//     dynamic params,
//   }) {
//     if (kDebugMode) {
//       final fullUrl = baseUrl + endPoint;
//       log("$method: $fullUrl Params: $params", name: "API");
//       log("$status => $exception", name: "API");
//       log("Response => ${bodyString}", name: "API");
//     }
//   }
//
//   _requestOk(Method method, String endpoint, dynamic params, dynamic response) {
//     if (kDebugMode) {
//       final fullUrl = baseUrl + endpoint;
//       log("$method: $fullUrl Params: $params", name: "API");
//       try {
//         const JsonDecoder decoder = JsonDecoder();
//         const JsonEncoder encoder = JsonEncoder.withIndent('  ');
//         final object = decoder.convert(response as String);
//         log("Response => ${encoder.convert(object)}", name: "API");
//       } catch (e) {
//         log(response.toString(), name: "API");
//       }
//     }
//   }
//
//   Future<Result> handlerResult(Result result, {String? endPoint}) async {
//     if (!result.success) {
//       if (result.code == 401) {
//         // onSessionTimeout(result);
//         // if (!(result.tikopException ?? false)) {
//         //   if (!(endPoint ?? "").contains(endPointLogin)) {
//         //     await Get.find<MainController>()
//         //         .refreshToken(() => refreshTokenSuccess());
//         //   }
//         // }
//         return Result(code: 401, tikopException: result.tikopException);
//       } else if (result.code == SESSION_TIMEOUT_CODE) {
//         //UNAUTHORIZED
//         // Get.find<MainController>().refreshToken(() => refreshTokenSuccess());
//         // return Result(code: 402);
//         return Result(code: 401, tikopException: result.tikopException);
//       } else if (result.code == BLOCK_OTP_1_CODE ||
//           result.code == BLOCK_OTP_2_CODE) {
//         onBlockOTP(result, endPoint: endPoint);
//         return Result();
//       } else if (result.code == BLOCK_SMART_OTP_CODE) {
//         onBlockSmartOtp(result);
//         return Result();
//       }
//     }
//     return result;
//   }
//
//   void onBlockSmartOtp(Result result) {
//     final dialog = CustomAlertDialog(
//       title: "Tài khoản tạm khóa OTP",
//       desc: result.error?.message ?? "",
//       actions: [
//         AlertAction.ok(() {
//           Get.back();
//           Get.until((route) =>
//               Get.currentRoute == AppRoutes.mainView ||
//               Get.currentRoute == AppRoutes.boardingVerifyPolicy);
//         })
//       ],
//     );
//     _showMessageDialog(dialog, name: "BlockSmartOTP", canDissmiss: false);
//   }
//
//   void onBlockOTP(Result result, {String? endPoint}) {
//     if (Get.isBottomSheetOpen ?? false) Get.back();
//
//     final dialog = CustomAlertDialog(
//       title: "Thông báo",
//       desc: result.error?.message ?? "",
//       actions: [
//         AlertAction.ok(() {
//           Get.back();
//           Get.until((route) =>
//               Get.currentRoute == AppRoutes.boardingVerifyPolicy ||
//               Get.currentRoute == AppRoutes.mainView);
//           // Get.back();
//           // Get.until(ModalRoute.withName(Routes.home));
//         })
//       ],
//     );
//
//     _showMessageDialog(dialog, name: "BlockOTP", canDissmiss: false);
//   }
//
//   Future onSessionTimeout(Result result) async {
//     final dialog = CustomAlertDialog(
//       desc: "Phiên đăng nhập đã hết hạn.\n Vui lòng đăng nhập lại.",
//       actions: [
//         AlertAction.ok(() {
//           Get.back();
//           TradingModule.clearCache();
//           Get.find<MainTradingProvider>().callToSignIn?.call();
//         })
//       ],
//     );
//     _showMessageDialog(dialog, name: "SessionTimeout", canDissmiss: false);
//     TradingModule.clearCache();
//     // await Get.find<MainController>().getDataLogin();
//   }
//
//   void _showMessageDialog(Widget dialog,
//       {String? name, bool canDissmiss = true}) {
//     if (shouldShowDialog(name)) {
//       if (Get.isDialogOpen ?? false) {
//         Get.back();
//         DUR_250.delay().then((value) =>
//             Get.dialog<Result>(dialog, barrierDismissible: canDissmiss));
//       } else {
//         Get.dialog<Result>(dialog, barrierDismissible: canDissmiss, name: name);
//       }
//     }
//   }
//
//   bool shouldShowDialog(String? dialogName) {
//     if (!(Get.isDialogOpen ?? false)) return true;
//     final route = Get.rawRoute;
//     if (dialogName != null && route is GetDialogRoute) {
//       return route.settings.name != dialogName &&
//           route.settings.name != "NetworkError";
//     }
//     return true;
//   }
//
//   void refreshTokenSuccess() {
//     //
//     final MainTradingProvider mainProvider = Get.find<MainTradingProvider>();
//     fullToken = mainProvider.accessToken ?? "";
//   }
//
//   Future<Result> onTimeOut(
//       {Method method = Method.GET,
//       required String endPoint,
//       dynamic params}) async {
//     log("onTimeOut=$endPoint");
//     return Result(
//         msg: "Có lỗi xảy ra. Vui lòng quay lại sau.", success: false, code: -1);
//   }
//
//   Future<Result> onServerError(
//       {Method method = Method.GET,
//       required String endPoint,
//       dynamic params}) async {
//     log("onServerError=$endPoint");
//     return Result(
//         msg: "Có lỗi xảy ra. Vui lòng quay lại sau.", success: false, code: -1);
//   }
// }
