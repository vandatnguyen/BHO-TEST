import 'dart:convert';

import 'package:finews_module/cores/models/news_detail.dart';
import 'package:finews_module/cores/services/news_api_service.dart';
import 'package:finews_module/cores/states/base_controller.dart';
import 'package:finews_module/data/entities/website.dart';
import 'package:finews_module/tracking/event_tracking.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:get_storage/get_storage.dart';

import 'home_page_controller.dart';

class HomePageMainController extends BaseController
    with GetTickerProviderStateMixin {
  List<Website> listWebsite = <Website>[];
  String categoryId = "666666";
  final box = GetStorage();
  final tabs = ["Tất cả"];
  final tabsId = ["666666"];
  String idSelected = "666666";
  late TabController tabController;
  int timeStart = 0;

  @override
  void onInit() {
    super.onInit();
    timeStart = DateTime.now().millisecondsSinceEpoch;
    idSelected = Get.arguments["idSelected"] as String;
    EventManager().fire(EventTrackingOpenModule());
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
              Get.lazyPut(() => NewsHomePageController(), tag: topic.id.toString());
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
    EventManager().fire(EventTrackingHomeViewTab(topicId: tabsId[0]));
    tabController.addListener(() {
      if (tabController.indexIsChanging) {
      }else{
        EventManager().fire(EventTrackingHomeViewTab(topicId: tabsId[tabController.index]));
      }
    });
  }

  @override
  void onClose() {
    tabController.dispose();
    try {
      if (timeStart > 0){
        var diff = DateTime.now().millisecondsSinceEpoch - timeStart;
        diff = (diff / 1000).round();
        EventManager().fire(EventTrackingCloseModule(timeSpent: diff));
      }
    } catch (e) {
      print(e);
    }
    super.onClose();
  }
}
