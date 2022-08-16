import 'package:finews_module/cores/services/news_api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_ticket_provider_mixin.dart';

import '../../cores/models/news_detail.dart';
import '../../cores/states/base_controller.dart';
import 'html_parser/html_parser.dart';
import 'html_parser/html_parser_shared.dart';

class NewsDetailController extends BaseController with GetSingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> offsetAnimation;
  late Animation<Offset> offsetBottomAnimation;
  final ScrollController scrollController = ScrollController();
  RxList<HtmlParserElement> elements = <HtmlParserElement>[].obs;

  double _pixels = 0;
  int _timestamp = 0;
  var isHideToolbar = false;

  NewsDetailModel? model;

  Future<void> loadContent() async { 
    var detail = await Get.find<NewsService>().getArticleInfo(id: "56:29:eb8d15cc7b99ee8793c6156c7cb85835");
    var html = Get.find<HtmlParser>();
    model = detail;
    html.parserHtml(detail.content ?? "");
    elements.clear(); 
    elements.addAll(html.elements);
  }

  String get pageTitle => "Title";

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(0, -1),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.decelerate,
    ));

    offsetBottomAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(0, 1),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.decelerate,
    ));

    scrollController.addListener(() {
      var offset = scrollController.offset;
      int timestamp = DateTime.now().millisecondsSinceEpoch;
      if (this._pixels != null && offset > 60) {
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