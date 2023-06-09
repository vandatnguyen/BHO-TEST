import 'dart:convert';

import 'package:finews_module/data/entities/website.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../cores/models/news_detail.dart';
import '../../cores/services/news_api_service.dart';

class NewsTradingBoxController extends GetxController
    with StateMixin<List<NewsDetailModel>>, GetTickerProviderStateMixin {
  final newsService = Get.find<NewsService>();

  late TabController tabController = TabController(vsync: this, length: 0);

  final tabs = ['Trang chủ'];
  final tabsId = ['222222'];
  List<Website> listWebsite = <Website>[];
  RxList<String> tabsRx = RxList();
  RxString tabsTitle = RxString("");
  RxList<String> tabsRx2 = RxList();

  String currentTag = "222222";
  final box = GetStorage();
  Map<String, List<NewsDetailModel>> cachedData = {};

  @override
  void onInit() {
    super.onInit();
    try {
      var websiteStringCached = box.read('websites');
      if (websiteStringCached != null) {
        listWebsite = (jsonDecode(websiteStringCached) as List)
            .map((website) => Website.fromJson(website))
            .toList();
      }
    } catch (e) {
      print(e);
    }
    // tabController = TabController(vsync: this, length: 1);
    // tabsRx.value = tabs;
    initWebsite();
  }

  void initWebsite() async {
    change([], status: RxStatus.loading());
    try {
      var response = await Get.find<NewsService>().getWebsite();
      listWebsite = response.websites;
      tabs.clear();
      tabsId.clear();
      listWebsite.forEach((element) {
        if (element.id == 222222) {
          tabsTitle.value = element.name;
          element.topic.forEach((topic) {
            tabs.add(topic.name);
            tabsId.add(topic.id.toString());
          });
        }
      });
      try {
        box.write(
                  'websites', jsonEncode(listWebsite.map((e) => e.toJson()).toList()));
        box.write(
                  'url_news_forum', response.forum);
      } catch (e) {
        print(e);
      }
      // listWebsiteRx.addAll();
      tabController = TabController(vsync: this, length: tabs.length);
      tabsRx.value = tabs;
      tabsRx2.value = tabs;
      setTag(tabsId[0]);
    } catch (e) {
      print(e);
      change([], status: RxStatus.empty());
    }
  }

  void onRefresh({bool isRefreshApi = false}) {
    if (listWebsite == null || listWebsite.isEmpty) {
      initWebsite();
    } else {
      setTag(currentTag, isRefreshApi: isRefreshApi);
    }
  }

  void onRefreshApi() {
    if (listWebsite == null || listWebsite.isEmpty) {
      initWebsite();
    } else {
      setTag(currentTag, isRefreshApi: true);
    }
  }

  void setTag(String tag, {bool isRefreshApi = false}) async {
    try {
      currentTag = tag;
      if (isRefreshApi || (cachedData[currentTag] == null || cachedData[currentTag]!.isEmpty)) {
        change([], status: RxStatus.loading());
        var res = await newsService.getArticleV2BySource(source: "222222",topic: tag, last: -1);
        if (res.articles.isEmpty){
          change([], status: RxStatus.empty());
          return;
        }
        for (var value in res.articles) {
          value.topicName = getTopicName(value.topic);
          value.sourceName = getSourceName(value.source);
          value.sourceIconUrl = getSourceIconUrl(value.source);
        }
        cachedData.putIfAbsent(currentTag, () => res.articles);
        change(res.articles, status: RxStatus.success());
      } else {
        change(cachedData[currentTag], status: RxStatus.success());
      }
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
