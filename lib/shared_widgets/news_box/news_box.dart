import 'package:finews_module/pages/home/new_page.dart';
import 'package:finews_module/shared_widgets/news_box/news_box_controller.dart';
import 'package:finews_module/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../pages/home/home_page.dart';

class BoxNews extends GetView<NewsBoxController> {
  const BoxNews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (listNews) {
        return ListView(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 16, left: 16),
              child: const Text(
                "Tin tức",
                style: TextStyle(
                  color: COLOR_333333,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            TabBar(
              isScrollable: true,
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 12,
              ),
              labelColor: COLOR_333333,
              labelStyle: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
              ),
              unselectedLabelColor: COLOR_858585,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(100), // Creates border
                  color: HexColor.fromHex('#F5F6FA')),
              controller: controller.tabController,
              onTap: (index) {
                controller.setTag(controller.tabs[index]);
              },
              tabs: controller.tabs
                  .map((e) => Tab(
                        text: e,
                      ))
                  .toList(),
            ),
            listNews == null
                ? const Center(
                    child: Text("Không có dữ liệu"),
                  )
                : Column(
                    children: [
                      ...listNews.take(3).toList().map((item) => NewsItem(
                            newsDetail: item,
                          )),
                      TextButton(
                        onPressed: () {
                          //todo: to news screen
                        },
                        child: const Text("Xem thêm"),
                      ),
                    ],
                  ),
          ],
        );
      },
    );
  }
}
