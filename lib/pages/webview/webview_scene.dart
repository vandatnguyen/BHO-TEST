import 'package:finews_module/pages/webview/webview_scene_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class WebViewScene extends GetView<WebviewController> {
  const WebViewScene({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        // title: Image.asset('assets/images/FiNews.png',
        //     package: 'finews_module', width: 90, height: 16),
        title: Text(controller.title, style: TextStyle(color: Colors.black)),
        // titleSpacing: 0,
        // leadingWidth: 8,
        centerTitle: false,
      ),
      body: Stack(
        children: [
          InAppWebView(
            key: controller.webViewKey,
            initialUrlRequest: URLRequest(url: Uri.parse(controller.url)),
            initialOptions: controller.options,
            pullToRefreshController: controller.pullToRefreshController,
            onWebViewCreated: (wController) {
              controller.onWebViewCreated(wController);
            },
            onLoadStart: (controller, url) {},
            androidOnPermissionRequest: (controller, origin, resources) async {
              return PermissionRequestResponse(
                  resources: resources,
                  action: PermissionRequestResponseAction.GRANT);
            },
            shouldOverrideUrlLoading: (wController, navigationAction) async {
              final uri = navigationAction.request.url!;

              if (![
                "http",
                "https",
                "file",
                "chrome",
                "data",
                "javascript",
                "about"
              ].contains(uri.scheme)) {
                if (await canLaunchUrl(Uri.parse(controller.url))) {
                  // Launch the App
                  await launchUrl(
                    Uri.parse(controller.url),
                  );
                  // and cancel the request
                  return NavigationActionPolicy.CANCEL;
                }
              }

              return NavigationActionPolicy.ALLOW;
            },
            onLoadStop: (wController, url) async {
              controller.pullToRefreshController.endRefreshing();
            },
            onJsConfirm: (controller,  jsConfirmRequest)async{
              print("onJsConfirm=${jsConfirmRequest.message}");
            },
            onLoadError: controller.loadWebError,
            onProgressChanged: controller.webProgress,
            onUpdateVisitedHistory: (controller, url, androidIsReload) {},
            onConsoleMessage: (controller, consoleMessage) {
              print("consoleMessage=$consoleMessage");
            },
          ),
          Obx(
                () {
              if (controller.progress < 1.0) {
                return LinearProgressIndicator(
                    value: controller.progress.value);
              } else {
                return Container();
              }
            },
          )
        ],
      ),
    );
  }
}
