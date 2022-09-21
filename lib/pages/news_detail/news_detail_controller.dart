import 'dart:convert';

import 'package:finews_module/cores/services/news_api_service.dart';
import 'package:finews_module/data/entities/website.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_ticket_provider_mixin.dart';

import '../../cores/models/news_detail.dart';
import '../../cores/states/base_controller.dart';
import 'html_parser/html_parser.dart';
import 'html_parser/html_parser_shared.dart';
import 'package:get_storage/get_storage.dart';

class NewsDetailController extends BaseController
    with GetSingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> offsetAnimation;
  late Animation<Offset> offsetBottomAnimation;
  final ScrollController scrollController = ScrollController();
  RxList<HtmlParserElement> elements = <HtmlParserElement>[].obs;
  RxList<NewsDetailModel> relativeNews = <NewsDetailModel>[].obs;

  double _pixels = 0;
  int _timestamp = 0;
  var isHideToolbar = false;

  NewsDetailModel? model;
  String? id;
  Rx<String?> error = Rx<String?>(null); 
  List<Website> listWebsite = <Website>[];

  NewsDetailController({this.model, this.id, required this.pageTitle}) {
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
        model = detail;
        content = model?.content ?? "";
      }
      print(content);
      var html = Get.find<HtmlParser>();
      await html.parserHtml(content);
      elements.clear();
      elements.addAll(html.elements);
      loadRecommend();
    } catch (e) {
    /*  Get.showSnackbar(const GetSnackBar(
          title: "Không tải được thông tin bài viết",
          message: "Vui lòng thử lại sau"));*/

          error.value = "Đã có lỗi xảy ra, vui lòng thử lại";
    } 
  }

  Future<void> loadRecommend() async {
    var relative =
        await Get.find<NewsService>().getArticleRelative(id: id ?? "");
    for (var value in relative.articles) {
      value.sourceName = getSourceName(value.source);
      value.topicName = getTopicName(value.topic);
    }
    relativeNews.addAll(relative.articles);
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

  final String pageTitle;

  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    var websiteStringCached = box.read('websites');
    if (websiteStringCached != null){
      listWebsite = (jsonDecode(websiteStringCached) as List).map((website) => Website.fromJson(website)).toList();
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
    });
  }

  @override
  void onReady() {
    super.onReady();
    loadContent();
  }

  @override
  void onClose() {
    scrollController.dispose();
    _controller.dispose();
    super.onClose();
  }
}
