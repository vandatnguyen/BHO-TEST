import 'dart:developer';
import 'dart:io';

import 'package:finews_module/cores/states/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class WebviewController extends BaseController{
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;

  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  late PullToRefreshController pullToRefreshController;
  String title = "Đăng ký tài khoản chứng khoán";
  String url = "";
  RxDouble progress = 0.0.obs;

  @override
  void onInit() {
    if(Get.parameters["title"]!=null){
      dynamic t =Get.parameters["title"]??"";
      title =t as String;
    }
    if(Get.parameters["link"]!=null){
      print("URL: " + url);
      dynamic l =Get.parameters["link"]??"";
      url =l as String;
    }
    print("URL: " + url);
    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(
              urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );
    super.onInit();
  }

  void loadWebFinished() {}

  void loadWebError(
      InAppWebViewController controller, Uri? url, int code, String message) {
    pullToRefreshController.endRefreshing();
  }

  void webProgress(InAppWebViewController controller, int pageProgress) {
    if (pageProgress == 100) {
      pullToRefreshController.endRefreshing();
    }
    progress.value = pageProgress / 100;
    log("progress=$progress");

  }

  void onWebViewCreated(InAppWebViewController wController) {
    webViewController = wController;
    // wController.addJavaScriptHandler(handlerName: 'handlerFoo', callback: (args) {
    //   // return data to the JavaScript side!
    //   return {
    //     'bar': 'bar_value', 'baz': 'baz_value'
    //   };
    // });
    //
    // wController.addJavaScriptHandler(handlerName: 'handlerFooWithArgs', callback: (args) {
    //   print(args);
    //   // it will print: [1, true, [bar, 5], {foo: baz}, {bar: bar_value, baz: baz_value}]
    // });


  }


}

