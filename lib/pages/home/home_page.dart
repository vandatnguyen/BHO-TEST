import 'package:finews_module/pages/home/new_page.dart';
import 'package:finews_module/shared_widgets/news_box/news_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

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
  late final _tabController = TabController(length: 4, vsync: this);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.black38,
            ),
            onPressed: () {
              // do something
            },
          )
        ],
        backgroundColor: Colors.white,
        title: Image.asset('assets/images/FiNews.png',
            package: 'finews_module', width: 90, height: 16),
        titleSpacing: 0,
        leadingWidth: 8,
        centerTitle: false,
        bottom: TabBar(
          isScrollable: true,
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 12,
          ),
          labelColor: Colors.white,
          labelStyle:
              const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          unselectedLabelStyle:
              const TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
          unselectedLabelColor: Colors.black,
          indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(10), // Creates border
              color: HexColor.fromHex('#58BD7D')),
          controller: _tabController,
          tabs: const <Widget>[
            // Tab(
            //   text: 'Box news',
            // ),
            Tab(
              text: 'Tất cả',
            ),
            Tab(
              text: 'Chứng khoán',
            ),
            Tab(
              text: 'Bất động sản',
            ),
            Tab(
              text: 'Doanh nghiệp',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // const BoxNews(),
          NewsPage(
            onNext: () => _tabController.index = 1,
            categoryId: "0",
          ),
          NewsPage(onNext: () => _tabController.index = 2, categoryId: "1"),
          NewsPage(onNext: () => _tabController.index = 3, categoryId: "2"),
          NewsPage(onNext: () => _tabController.index = 4, categoryId: "3"),
        ],
      ),
    );
  }
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
