import 'package:finews_module/pages/webview/webview_scene_controller.dart';
import 'package:get/get.dart';

class WebviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WebviewController());
  }
}
