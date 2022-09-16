import 'dart:convert';

import 'package:finews_module/data/entities/website.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../cores/models/news_detail.dart';
import '../../cores/services/news_api_service.dart';

class NewsBoxController extends GetxController
    with StateMixin<List<NewsDetailModel>>, GetTickerProviderStateMixin {

  final newsService = Get.find<NewsService>();

  late TabController tabController;

  final tabs = ['Tất cả', 'Chứng khoán', 'Bất động sản', 'Doanh nghiệp'];
  final tabsId = ['666666', '31', '34', '30'];
  List<Website> listWebsite = <Website>[];

  String currentTag = "666666";
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: tabs.length);
    setTag("666666");
    try {
      var websiteStringCached = box.read('websites');
      if (websiteStringCached != null){
            listWebsite = (jsonDecode(websiteStringCached) as List).map((website) => Website.fromJson(website)).toList();
          }
    } catch (e) {
      print(e);
    }
  }

  void onRefresh() {
    setTag(currentTag);
  }

  void setTag(String tag) async {
    try {
      currentTag = tag;
      change([], status: RxStatus.loading());
      var response = await Get.find<NewsService>().getWebsite();
      listWebsite = response.websites;
      box.write('websites', jsonEncode(listWebsite.map((e) => e.toJson()).toList()));
      var res = await newsService.getArticleV2(topic: tag,last: -1);
      for (var value in res.articles) {
        value.topicName = getTopicName(value.topic);
        value.sourceName = getSourceName(value.source);
        value.sourceIconUrl = getSourceIconUrl(value.source);
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

  String? getSourceIconUrl(int id) {
    for (var t in listWebsite) {
      if (t.id == id) {
        return t.iconUrl;
      }
    }
    return "";
  }
}
