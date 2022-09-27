import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_notifier.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../cores/models/news_detail.dart';
import '../../cores/services/news_api_service.dart';
import '../../cores/states/base_controller.dart';
import '../../data/entities/website.dart';
import 'list_news.dart';

class ListNewsController extends BaseController
    with StateMixin<List<NewsDetailModel>> {
  ListNewsController(this.detail, this.type);

  List<Website> listWebsite = <Website>[];
  final NewsDetailModel detail;
  final ListNewsType type;
  RefreshController refreshController = RefreshController();
  var service = Get.find<NewsService>();
  var box = GetStorage();
  bool _loadEnd = false;

  double last = -1;

  List<NewsDetailModel> listNews = [];

  Future<List<NewsDetailModel>> getNewsList() async {
    switch (type) {
      case ListNewsType.typeTag:
        {
          var res = await service.getArticleWithTopic(
            detail.id,
            last: last,
          );
          last = res.last;
          return res.articles;
        }

      case ListNewsType.typeStock:
        {
          var res = await service.getArticleStock(
            detail.symbols?[0] ?? "",
            last: last,
          );
          last = res.last;
          return res.articles;
        }

      default:
        {
          return [];
        }
    }
  }

  @override
  void onInit() {
    super.onInit();
    print("get tag: "+ detail.id + type.name);
    if (box.hasData('websites')) {
      var websiteStringCached = box.read('websites');
      if (websiteStringCached != null) {
        listWebsite = (jsonDecode(websiteStringCached) as List)
            .map((website) => Website.fromJson(website))
            .toList();
      }
    }
    onRefresh();
  }

  Future onRefresh() async {
    last = -1;
    onLoad(isLoadMore: false);
    refreshController.refreshCompleted();
  }

  Future onLoad({isLoadMore = true}) async {
    try {
      if (_loadEnd && isLoadMore){
        return;
      }
      var res = await getNewsList();
      if (!isLoadMore) {
        listNews.clear();
      }
      if (res.isEmpty){
        _loadEnd = true;
      }else{
        _loadEnd = false;
      }
      for (var element in res) {
        element.topicName = getTopicName(element.topic);
        element.sourceName = getSourceName(element.source);
      }
      listNews.addAll(res);
      debugPrint(listNews.toString());
      change(listNews, status: RxStatus.success());
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
        change(listNews, status: RxStatus.error());
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
    return null;
  }

  String? getSourceName(int id) {
    for (var t in listWebsite) {
      if (t.id == id) {
        return t.name;
      } else {
        // for (var e in t.topic) {
        //   if (e.id == id){
        //     return e.name;
        //   }
        // }
      }
    }
    return "123";
  }

  String? get title {
    switch (type) {
      case ListNewsType.typeStock:
        {
          return detail.symbols?[0];
        }

      case ListNewsType.typeTag:
        {
          return detail.topicName;
        }

      default:
        {
          return "";
        }
    }
  }
}
