import 'dart:convert';
import 'dart:math';

import 'package:finews_module/cores/models/news_detail.dart';
import 'package:finews_module/cores/resources/data_state.dart';
import 'package:finews_module/cores/services/news_api_service.dart';
import 'package:finews_module/cores/states/base_controller.dart';
import 'package:finews_module/data/entities/list_currency_response.dart';
import 'package:finews_module/data/entities/list_gold_response.dart';
import 'package:finews_module/data/entities/website.dart';
import 'package:finews_module/shared_widgets/stockchart/market_index_model.dart';
import 'package:finews_module/shared_widgets/stockchart/market_index_model_dto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NewsHomePageController extends BaseController
    with StateMixin<List<ArticleWrapper>> {
  RefreshController refreshController = RefreshController();
  List<ArticleWrapper> listArticle = <ArticleWrapper>[];
  List<Website> listWebsite = <Website>[];
  String categoryId = "666666";
  final box = GetStorage();
  bool _loadEnd = false;
  double _last = -1;

  @override
  void onInit() {
    super.onInit();
    getWebsite();
    // getStockIndex();
    // getGold();
    // getCurrency();
  }

  Future onRefresh() async {
    getWebsite();
    refreshController.refreshCompleted();
  }

  Future onLoadMore() async {
    if (!_loadEnd) {
      getArticleV2(isLoadMore: true);
      refreshController.loadComplete();
      return;
    }
  }

  var listGoldRes = Rxn<ListGoldResponse>();
  var listCurrencyRes = Rxn<ListCurrencyResponse>();

  void getGold() async {
    try {
      var response = await Get.find<NewsService>().getListGold();
      listGoldRes(response);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {}
  }

  void getCurrency() async {
    try {
      var response = await Get.find<NewsService>().getListCurrency();
      listCurrencyRes(response);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {}
  }

  RxList<MarketIndexModel> listMarketCate = <MarketIndexModel>[].obs;
  void getStockIndex() async {
    try {
      var result = await Get.find<NewsService>().getMarketIndex();
      if (result.success) {
        var model = result.modelDTO;
        final List<MarketIndexModel> list =[];
        for (final value in model) {
          list.add(value.toModel());
        }
        listMarketCate.value = list;
      }
    } catch (e) {
      if (kDebugMode) {
        print("getStockIndex: " + e.toString());
      }
    } finally {}
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

  String? getSourceIconUrl(int id) {
    for (var t in listWebsite) {
      if (t.id == id) {
        return t.iconUrl;
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
      if (listArticle.articles.isEmpty) {
        _loadEnd = true;
      } else {
        _loadEnd = false;
      }
      try {
        if (categoryId == "31"){
                try {
                  if (this.listArticle.isNotEmpty) {
                            for (var value in this.listArticle) {
                              if (value.type == 5) {
                                this.listArticle.remove(value);
                              }
                            }
                          }
                } catch (e) {
                  print(e);
                }
                var wrapper = ArticleWrapper();
                wrapper.type = 5;
                this.listArticle.insert(0,wrapper);
              }
      } catch (e) {
        print(e);
      }
      for (var value in listArticle.articles) {
        var wrapper = ArticleWrapper();
        value.topicName = getTopicName(value.topic);
        value.sourceName = getSourceName(value.source);
        value.sourceIconUrl = getSourceIconUrl(value.source);
        wrapper.model = value;
        this.listArticle.add(wrapper);
      }
      if (this.listArticle.length <= 20){
        for (var value in this.listArticle) {
          if (value.type == 3 || value.type == 4) {
            this.listArticle.remove(value);
          }
        }
        var wrapper = ArticleWrapper();
        wrapper.type = 3;
        this.listArticle.insert(10, wrapper);
        var wrapper2 = ArticleWrapper();
        wrapper2.type = 4;
        this.listArticle.insert(20, wrapper2);
        print("listArticle size: getGold getCurrency");
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
            content: Text(
                'Có lỗi xảy ra, vui lòng kiểm tra kết nối mạng và thử lại'),
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
    var detail =
        listArticle.articles[Random().nextInt(listArticle.articles.length)];
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
        value.sourceIconUrl = getSourceIconUrl(value.source);
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
}

class ArticleWrapper {
  int type = 0;
  late List<NewsDetailModel> listNewsDetailModel;
  late NewsDetailModel model;
}
