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
import 'home_page_main_controller.dart';

class HomePageView extends GetView<HomePageMainController> {
  const HomePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeApplicationFlow(controller);
  }
}

class HomeApplicationFlow extends StatefulWidget {
  HomePageMainController controller;
  HomeApplicationFlow(this.controller, {Key? key}) : super(key: key);

  @override
  _HomeApplicationFlowState createState() => _HomeApplicationFlowState(controller);
}

class _HomeApplicationFlowState extends State<HomeApplicationFlow> {
  HomePageMainController controller;
  _HomeApplicationFlowState(this.controller);

  // List<Website> listWebsite = <Website>[];
  // final box = GetStorage();
  // int index = 0;


  @override
  Widget build(BuildContext context) {
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
          controller: controller.tabController,
          tabs: controller.tabs
              .map((e) => Tab(
                    text: e,
                  ))
              .toList(),
        ),
      ),
      body: TabBarView(
        controller: controller.tabController,
        children: controller.tabsId
            .map((e) => NewsPage(
                  onNext: () => controller.tabController.index = controller.tabController.index++,
                  categoryId: e,
                ))
            .toList(),
      ),
    );
  }
}
