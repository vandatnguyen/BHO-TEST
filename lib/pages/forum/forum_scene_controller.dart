import 'dart:developer';
import 'dart:io';

import 'package:finews_module/cores/states/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ForumController extends BaseController {
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
  String title = "";
  String url = "";
  String tikopToken = "";
  String urlForum = "";
  RxDouble progress = 0.0.obs;

  @override
  void onInit() {
    var box = GetStorage();
    try {
      tikopToken = box.read("tikop_token");
    } catch (e) {
      print(e);
    }
    try {
      urlForum = box.read("url_news_forum");
    } catch (e) {
      print(e);
    }
    title = "Cộng đồng";
    if (urlForum.isNotEmpty){
      url = urlForum + "home?redirect_path=/&access_token=" +
          tikopToken;
    }else {
      url = "https://forum.r14express.vn/home?redirect_path=/&access_token=" +
          tikopToken;
    }
    print("4rum url" + url);
    // url = "https://forum.r14express.vn/";
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
