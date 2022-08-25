import 'package:finews_module/cores/models/news_detail.dart';
import 'package:finews_module/cores/services/news_api_service.dart';
import 'package:finews_module/pages/news_detail/html_parser/html_parser.dart';
import 'package:get/get.dart';

import 'news_detail_controller.dart';

class NewsDetailBinding extends Bindings {
  @override
  void dependencies() {
    if (Get.arguments != null && Get.arguments["news"] is NewsDetailModel) {
      NewsDetailModel item = Get.arguments["news"] as NewsDetailModel;
      Get.lazyPut(
          () => NewsDetailController(
              model: item, pageTitle: Get.arguments["title"] ?? ""),
          tag: item.id);
    } else if (Get.arguments != null && Get.arguments["id"] is String) {
      String id = Get.arguments["id"] as String;
      Get.lazyPut(
          () => NewsDetailController(
              id: id, pageTitle: Get.arguments["title"] ?? ""),
          tag: id);
    } else {
      Get.lazyPut(
          () => NewsDetailController(pageTitle: Get.arguments["title"] ?? ""));
    }
  }
}
