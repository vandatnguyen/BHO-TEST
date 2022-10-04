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

  late TabController tabController = TabController(vsync: this, length: 0);

  final tabs = ['Trang chủ'];
  final tabsId = ['666666'];
  List<Website> listWebsite = <Website>[];
  RxList<String> tabsRx = RxList();
  RxList<String> tabsRx2 = RxList();

  String currentTag = "666666";
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
        if (element.id == 666666) {
          element.topic.forEach((topic) {
            tabs.add(topic.name);
            tabsId.add(topic.id.toString());
          });
        }
      });
      box.write(
          'websites', jsonEncode(listWebsite.map((e) => e.toJson()).toList()));
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

  void onRefresh() {
    if (listWebsite == null || listWebsite.isEmpty) {
      initWebsite();
    } else {
      setTag(currentTag);
    }
  }

  void setTag(String tag) async {
    try {
      currentTag = tag;
      if (cachedData[currentTag] == null || cachedData[currentTag]!.isEmpty) {
        change([], status: RxStatus.loading());
        var res = await newsService.getArticleV2(topic: tag, last: -1);
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
