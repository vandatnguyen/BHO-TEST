import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../cores/models/news_detail.dart';
import '../../cores/services/news_api_service.dart';

class NewsBoxController extends GetxController
    with StateMixin<List<NewsDetailModel>>, GetTickerProviderStateMixin {
  final newsService = Get.find<NewsService>();

  late TabController tabController;

  final tabs = ['Tất cả', 'Chứng khoán', 'Bất động sản', 'Doanh nghiệp'];

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: tabs.length);
    setTag(tabs[0]);
  }

  void setTag(String tag) async {
    try {
      var res = await newsService.getArticleWithTag(tag);
      change(res.articles, status: RxStatus.success());
    } catch (e) {
      debugPrint(e.toString());
      change([], status: RxStatus.empty());
    }
  }
}
