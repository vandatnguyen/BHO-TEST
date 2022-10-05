import 'dart:convert';

import 'package:finews_module/data/entities/website.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../cores/models/news_detail.dart';
import '../../cores/services/news_api_service.dart';

class NewsStockBoxController extends GetxController
    with StateMixin<List<NewsDetailModel>>, GetTickerProviderStateMixin {
  final newsService = Get.find<NewsService>();

  RefreshController refreshController = RefreshController();

  List<Website> listWebsite = <Website>[];
  List<NewsDetailModel> listData = <NewsDetailModel>[];
  RxList<String> tabsRx = RxList();
  RxList<String> tabsRx2 = RxList();
  double last = -1;

  final box = GetStorage();

  late String stockName;

  bool _loadEnd = false;

  @override
  void onInit() {
    super.onInit();
    try {
      stockName = "ACB";
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
      box.write(
          'websites', jsonEncode(listWebsite.map((e) => e.toJson()).toList()));
      setTag(stockName);
    } catch (e) {
      print(e);
      change([], status: RxStatus.empty());
    }
  }

  void onRefresh() {
    if (listWebsite == null || listWebsite.isEmpty) {
      initWebsite();
    } else {
      setTag(stockName);
    }
  }

  void setTag(String tag) async {
    try {
      listData.clear();
      last = -1;
      _loadEnd = false;
      change([], status: RxStatus.loading());
      var res = await newsService.getArticleStock(stockName, last: last);
      for (var value in res.articles) {
        value.topicName = getTopicName(value.topic);
        value.sourceName = getSourceName(value.source);
        value.sourceIconUrl = getSourceIconUrl(value.source);
      }
      listData.addAll(res.articles);
      last = res.last;
      change(listData, status: RxStatus.success());
    } catch (e) {
      debugPrint(e.toString());
      change([], status: RxStatus.empty());
    }
  }

  Future onLoad({isLoadMore = true}) async {
    try {
      if (_loadEnd && isLoadMore){
        return;
      }
      var res = await newsService.getArticleStock(stockName, last: last);
      if (!isLoadMore) {
        res.articles.clear();
      }
      last = res.last;
      if (res.articles.isEmpty){
        _loadEnd = true;
      }else{
        _loadEnd = false;
      }
      for (var element in res.articles) {
        element.topicName = getTopicName(element.topic);
        element.sourceName = getSourceName(element.source);
        element.sourceIconUrl = getSourceIconUrl(element.source);
      }
      listData.addAll(res.articles);
      change(listData, status: RxStatus.success());
    } catch (e) {
      if (isLoadMore){
        final scaffold = ScaffoldMessenger.of(Get.context!);
        scaffold.showSnackBar(
          const SnackBar(
            content: Text('Có lỗi xảy ra, vui lòng kiểm tra kết nối mạng và thử lại'),
            backgroundColor: Colors.green,
          ),
        );
      }else {
        change(listData, status: RxStatus.error());
      }
    } finally {
      refreshController.loadComplete();
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
