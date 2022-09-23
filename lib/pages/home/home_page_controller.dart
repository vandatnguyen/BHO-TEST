import 'dart:convert';

import 'package:finews_module/cores/models/news_detail.dart';
import 'package:finews_module/cores/services/news_api_service.dart';
import 'package:finews_module/cores/states/base_controller.dart';
import 'package:finews_module/data/entities/website.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:get_storage/get_storage.dart';

class HomePageController extends BaseController
    with GetSingleTickerProviderStateMixin, StateMixin<List<ArticleWrapper>>{
  RefreshController refreshController = RefreshController();
  List<ArticleWrapper> listArticle = <ArticleWrapper>[];
  List<Website> listWebsite = <Website>[];
  String categoryId = "666666";
  final box = GetStorage();

  bool _loadEnd = false;

  double _last = -1;

  final tabs = ["Tất cả"];
  final tabsId = ["666666"];
  String idSelected = "666666";
  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    idSelected = Get.arguments["idSelected"] as String;
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
    int index = 0;
    int i = 0;
    try {
      if (listWebsite.isNotEmpty) {
        tabs.clear();
        tabsId.clear();
        listWebsite.forEach((element) {
          if (element.id == 666666) {
            element.topic.forEach((topic) {
              tabs.add(topic.name);
              tabsId.add(topic.id.toString());
              Get.lazyPut(() => HomePageController(), tag: topic.id.toString());
              if (idSelected == topic.id.toString()) {
                index = i;
              }
              i++;
            });
          }
        });
      }
    } catch (e) {
      print(e);
    }
    tabController =
        TabController(length: tabs.length, vsync: this, initialIndex: index);

    getWebsite();
  }

  Future onRefresh() async {
    getWebsite();
    refreshController.refreshCompleted();
  }

  Future onLoadMore() async {
    print('onLoadMore:');
    if (!_loadEnd) {
      getArticleV2(isLoadMore: true);
      refreshController.loadComplete();
      return;
    }
  }

  Future getWebsite() async {
    try {
      change([], status: RxStatus.loading());
      var response = await Get.find<NewsService>().getWebsite();
      listWebsite = response.websites;
      box.write(
          'websites', jsonEncode(listWebsite.map((e) => e.toJson()).toList()));
    } catch (e) {
      print(e);
    }

    await getArticleV2();
    if (categoryId == "666666") {
      await getArticleHots();
      await getArticleHotsV2();
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

  Future getArticleV2({bool isLoadMore = false}) async {
    try {
      if (isLoadMore == false) {
        change([], status: RxStatus.loading());
      }
      var listArticle = await Get.find<NewsService>()
          .getArticleV2(topic: categoryId, last: _last);
      _last = listArticle.last;
      if (listArticle.articles.isEmpty){
        _loadEnd = true;
      }else{
        _loadEnd = false;
      }
      for (var value in listArticle.articles) {
        var wrapper = ArticleWrapper();
        value.topicName = getTopicName(value.topic);
        value.sourceName = getSourceName(value.source);
        wrapper.model = value;
        this.listArticle.add(wrapper);
      }
      change(this.listArticle, status: RxStatus.success());
    } catch (e) {
      print(e);
      if (!isLoadMore) {
        change([], status: RxStatus.empty());
      } else {
        final scaffold = ScaffoldMessenger.of(Get.context!);
        scaffold.showSnackBar(
          const SnackBar(
            content: Text('Có lỗi xảy ra, vui lòng kiểm tra kết nối mạng và thử lại'),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }

  Future getArticleHots() async {
    var listArticle = await Get.find<NewsService>().getArticleHots(topic: "31");
    if (this.listArticle.isNotEmpty) {
      if (this.listArticle[0].type == 1) {
        this.listArticle.removeAt(0);
      }
    }
    var wrapper = ArticleWrapper();
    wrapper.type = 1;
    var detail = listArticle.articles[0];
    detail.sourceName = getSourceName(detail.source);
    detail.topicName = getTopicName(detail.topic);
    wrapper.model = detail;
    this.listArticle.insert(0, wrapper);
    change(this.listArticle, status: RxStatus.success());
  }

  Future getArticleHotsV2() async {
    var listArticle =
        await Get.find<NewsService>().getArticleHotsV2(topic: "31");

    if (this.listArticle.length > 2) {
      var wrapper = ArticleWrapper();
      wrapper.type = 2;
      wrapper.listNewsDetailModel = listArticle.articles;
      for (var value in listArticle.articles) {
        var wrapper = ArticleWrapper();
        value.topicName = getTopicName(value.topic);
        value.sourceName = getSourceName(value.source);
        wrapper.model = value;
        this.listArticle.add(wrapper);
      }
      for (var value in this.listArticle) {
        if (value.type == 2) {
          this.listArticle.remove(value);
          this.listArticle.insert(3, wrapper);
          change(this.listArticle, status: RxStatus.success());
          return;
        }
      }
      this.listArticle.insert(3, wrapper);
      change(this.listArticle, status: RxStatus.success());
    }
  }

  // @override
  // void onClose() {
  //   tabController.dispose();
  //   super.onClose();
  // }
}

class ArticleWrapper {
  int type = 0;
  late List<NewsDetailModel> listNewsDetailModel;
  late NewsDetailModel model;
}
