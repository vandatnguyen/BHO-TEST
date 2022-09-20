import 'dart:convert';

import 'package:finews_module/data/entities/website.dart';
import 'package:finews_module/pages/home/new_page.dart';
import 'package:finews_module/shared_widgets/news_box/news_box.dart';
import 'package:finews_module/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get_storage/get_storage.dart';

import 'home_page_controller.dart';

class HomePageView extends GetView<HomePageController> {
  const HomePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const HomeApplicationFlow();
  }
}

class HomeApplicationFlow extends StatefulWidget {
  const HomeApplicationFlow({Key? key}) : super(key: key);

  @override
  _HomeApplicationFlowState createState() => _HomeApplicationFlowState();
}

class _HomeApplicationFlowState extends State<HomeApplicationFlow>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final tabs = ["Tất cả"];
  final tabsId = ["666666"];
  List<Website> listWebsite = <Website>[];
  final box = GetStorage();
  int index = 0;

  String idSelected = "666666";

  @override
  Widget build(BuildContext context) {
    idSelected = Get.arguments["idSelected"] as String;
    Get.lazyPut(() => HomePageController(), tag: "666666");
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
    _tabController =
        TabController(length: tabs.length, vsync: this, initialIndex: index);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        // actions: <Widget>[
        //   IconButton(
        //     icon: const Icon(
        //       Icons.search,
        //       color: Colors.black38,
        //     ),
        //     onPressed: () {
        //       // do something
        //     },
        //   )
        // ],
        backgroundColor: Colors.white,
        // title: Image.asset('assets/images/FiNews.png',
        //     package: 'finews_module', width: 90, height: 16),
        title: Text('Tin tức', style: TextStyle(color: Colors.black)),
        // titleSpacing: 0,
        // leadingWidth: 8,
        centerTitle: false,
        bottom: TabBar(
          isScrollable: true,
          padding: const EdgeInsets.symmetric(
            // vertical: 12,
            horizontal: 8,
          ),
          labelColor: Colors.white,
          labelStyle:
              const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          unselectedLabelStyle:
              const TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
          unselectedLabelColor: Colors.black,
          indicator: BoxDecoration(
              border: Border.all(color: Colors.white, width: 4),
              borderRadius: BorderRadius.circular(10), // Creates border
              color: HexColor.fromHex('#58BD7D')),
          controller: _tabController,
          tabs: tabs
              .map((e) => Tab(
                    text: e,
                  ))
              .toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: tabsId
            .map((e) => NewsPage(
                  onNext: () => _tabController.index = index++,
                  categoryId: e,
                ))
            .toList(),
      ),
    );
  }
}
