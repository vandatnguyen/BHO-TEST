import 'package:finews_module/data/entities/website.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../cores/models/news_detail.dart';
import '../../cores/services/news_api_service.dart';

class NewsBoxController extends GetxController
    with StateMixin<List<NewsDetailModel>>, GetTickerProviderStateMixin {

  final newsService = Get.find<NewsService>();

  late TabController tabController;

  final tabs = ['Tất cả', 'Chứng khoán', 'Bất động sản', 'Doanh nghiệp'];
  List<Website> listWebsite = <Website>[];

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: tabs.length);
    setTag(tabs[0]);
  }

  void setTag(String tag) async {
    try {
      var response = await Get.find<NewsService>().getWebsite();
      listWebsite = response.websites;
      var res = await newsService.getArticleV2(topic: tag);
      for (var value in res.articles) {
        // var wrapper = ArticleWrapper();
        value.topicName = getTopicName(value.topic);
        value.sourceName = getSourceName(value.source);
      }
      change(res.articles, status: RxStatus.success());
    } catch (e) {
      debugPrint(e.toString());
      change([], status: RxStatus.empty());
    }
  }

  String? getTopicName(int id) {
    for (var value in listWebsite) {
      for (var t in value.topic) {
        if (t.id == id) {
          return t.name;
        }
      }
    }
    return "";
  }

  String? getSourceName(int id) {
    for (var t in listWebsite) {
      if (t.id == id) {
        return t.name;
      }
    }
    return "";
  }
}
