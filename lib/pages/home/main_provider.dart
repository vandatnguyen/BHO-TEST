import 'dart:developer';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info/package_info.dart';
import '../../cores/states/base_common_widget.dart';

class MainFiNewsProvider with BaseCommonWidgets {
   
  GetStorage get box => GetStorage();
  final BaseCacheManager imageCacheManager = DefaultCacheManager();
  final _connectivity = Connectivity();
 
  MainFiNewsProvider();
 
  Future loadDataDeviceInfo() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion = packageInfo.version;

    try {
      if (Platform.isAndroid) {
        final data = await deviceInfoPlugin.androidInfo;
        deviceId = data.id ?? '';
        osVersion = data.version.release ?? '0.0';
        deviceName = data.model ?? '';
      } else if (Platform.isIOS) {
        final data = await deviceInfoPlugin.iosInfo;
        deviceId = data.identifierForVendor ?? '';
        osVersion = data.systemVersion ?? '0.0';
        deviceName = data.name ?? '';
      }
    } on PlatformException {
      log("Cant get device info");
    }
    String platform = "";
    if (Platform.isAndroid) {
      platform = "android";
    } else if (Platform.isIOS) {
      platform = "ios";
    } else {
      return;
    }
  }

  String deviceId = "";
  String deviceName = "";
  String appVersion = "";
  String appTradingVersion = "";
  String osVersion = "";
  String? accessToken;
  String? userId;

  // set accessToken(String? accessToken) => _accessToken;

  void clearAccessToken() {
    accessToken = null; 
  }
 

  Future<bool> hasConnectInternet() async {
    ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
      return result != ConnectivityResult.none;
    } on PlatformException catch (e) {
      log(e.toString());
    }
    return false;
  }

  Future<void> checkConnect() async {
    ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
      _updateStatus(result);
      _connectivity.onConnectivityChanged.listen((event) {
        _updateStatus(event);
      });
    } on PlatformException catch (e) {
      log(e.toString());
    }
  }

  void _updateStatus(ConnectivityResult event) {
    switch (event) {
      case ConnectivityResult.wifi:
        break;
      case ConnectivityResult.mobile:
        break;
      case ConnectivityResult.none:
        hideDialog();
       // Get.dialog(NetworkDialog(), name: "NetworkError");
        break;
    }
  }
}
