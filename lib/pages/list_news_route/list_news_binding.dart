import 'package:finews_module/pages/list_news_route/list_news.dart';
import 'package:finews_module/pages/list_news_route/list_news_controller.dart';
import 'package:get/get.dart';

import '../../cores/models/news_detail.dart';

class ListNewsBinding extends Bindings {
  @override
  void dependencies() {
    try {
      final ListNewsType type = Get.arguments["type"];
      NewsDetailModel detail = Get.arguments["item"];
      if (type.name == ListNewsType.typeTag.name){
        final String tag = Get.arguments["tag"];
        Get.lazyPut(
                () =>
                ListNewsController(
                  detail,
                  type,
                  tag,
                )
            , tag: tag + type.name);
      }else {
        Get.lazyPut(
                () =>
                ListNewsController(
                  detail,
                  type,
                  "",
                )
            , tag: detail.id + type.name);
      }
    } catch (e) {
      print(e);
    }
  }
}
