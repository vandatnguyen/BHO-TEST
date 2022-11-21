import 'dart:convert';

import 'package:finews_module/cores/models/comment_model.dart';
import 'package:finews_module/cores/services/news_api_service.dart';
import 'package:finews_module/data/entities/list_currency_response.dart';
import 'package:finews_module/data/entities/list_gold_response.dart';
import 'package:finews_module/data/entities/website.dart';
import 'package:finews_module/tracking/event_tracking.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../cores/models/news_detail.dart';
import '../../cores/states/base_controller.dart';
import 'html_parser/html_parser.dart';
import 'html_parser/html_parser_shared.dart';

class NewsDetailController extends BaseController
    with GetSingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> offsetAnimation;
  late Animation<Offset> offsetBottomAnimation;
  final ScrollController scrollController = ScrollController();
  RxList<HtmlParserElement> elements = <HtmlParserElement>[].obs;
  RxList<NewsDetailModel> relativeNews = <NewsDetailModel>[].obs;
  var comments = <CommentModel>[].obs;

  double _pixels = 0;
  int _timestamp = 0;
  int timeRead = 0;
  var isHideToolbar = false;

  NewsDetailModel? model;
  String? id;

  String? pageTitle = "";

  Rx<String?> error = Rx<String?>(null);
  List<Website> listWebsite = <Website>[];

  NewsDetailController({this.model, this.id, this.pageTitle}) {
    id ??= model?.id;
  }

  Future<void> loadContent() async {
    try {
      String content = "";
      if (model != null) {
        id = model?.id;
      }
      if (model != null && (model?.content ?? "").isNotEmpty) {
        content = model?.content ?? "";
      } else {
        var detail = await Get.find<NewsService>().getArticleInfo(id: id ?? "");
        detail.topicName = getTopicName(detail.topic);
        detail.sourceName = getSourceName(detail.source);
        detail.sourceIconUrl = getSourceIconUrl(detail.source);
        model = detail;
        content = model?.content ?? "";
        EventManager().fire(EventTrackingReadingNews(model: detail));
        timeRead = DateTime.now().millisecondsSinceEpoch;
        error.value = null;
        checkToLoadGoldOrCurrency();
      }
      var html = Get.find<HtmlParser>();
      await html.parserHtml(content);
      elements.clear();
      elements.addAll(html.elements);
      loadRecommend();
    } catch (e) {
      error.value = "Đã có lỗi xảy ra, vui lòng thử lại";
    }
  }

  void checkToLoadGoldOrCurrency() {
    if (model?.stockInfo != null && (model?.stockInfo?.length ?? 0) > 0) {
    } else {
      if (model!.title.toLowerCase().contains("vàng") ||
          model!.title.toLowerCase().contains("bạc")) {
        getGold();
      }else{
        if (model!.title.toLowerCase().contains("usd")) {
          getCurrency();
        }
      }
    }
  }

  Future<void> loadRecommend() async {
    var relative =
        await Get.find<NewsService>().getArticleRelative(id: id ?? "");
    for (var value in relative.articles) {
      value.sourceName = getSourceName(value.source);
      value.topicName = getTopicName(value.topic);
      value.sourceIconUrl = getSourceIconUrl(value.source);
    }
    relativeNews.addAll(relative.articles);
  }

  Future<void> loadComment() async {
    if (model != null) {
      id = model?.id;
    }
    var res = await Get.find<NewsService>().getAllComment(id ?? "");
    comments(res.comments);
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

  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    var websiteStringCached = box.read('websites');
    if (websiteStringCached != null) {
      listWebsite = (jsonDecode(websiteStringCached) as List)
          .map((website) => Website.fromJson(website))
          .toList();
    }
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, -1),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.decelerate,
    ));

    offsetBottomAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, 1),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.decelerate,
    ));

    scrollController.addListener(() {
      try {
        var offset = scrollController.offset;
        int timestamp = DateTime.now().millisecondsSinceEpoch;
        if (offset > 60) {
          final double velocity = (offset - _pixels) / (timestamp - _timestamp);

          if (velocity > 1 && !isHideToolbar) {
            _controller.forward();
            isHideToolbar = true;
          } else if (velocity < 0 && isHideToolbar) {
            _controller.reverse();
            isHideToolbar = false;
          }
        }
        _pixels = offset;
        _timestamp = timestamp;
      } catch (e) {
        // print(e);
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
    loadContent();
    loadComment();
    try {
    } catch (e) {
      print(e);
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    _controller.dispose();
    if (model != null) {
      if (timeRead > 0) {
        var diff = DateTime.now().millisecondsSinceEpoch - timeRead;
        diff = (diff / 1000).round();
        EventManager().fire(EventTrackingReadingNewsEnd(
          model: model!,
          time: diff,
        ));
      }
    }
    super.onClose();
  }

  var listGoldRes = Rxn<ListGoldResponse>();
  var listCurrencyRes = Rxn<ListCurrencyResponse>();

  void getGold() async {
    try {
      var response = await Get.find<NewsService>().getListGold();
      listGoldRes(response);
    } catch (e) {
      print(e);
    } finally {}
  }

  void getCurrency() async {
    try {
      var response = await Get.find<NewsService>().getListCurrency();
      listCurrencyRes(response);
    } catch (e) {
      print(e);
    } finally {}
  }
}
