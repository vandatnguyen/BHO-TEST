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

class MainFiNewsTradingProvider with BaseCommonWidgets {

  Function(String stockSymbol)? openStockDetail;
  MainFiNewsTradingProvider(this.openStockDetail);

}
