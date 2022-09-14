import 'package:finews_module/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../pages/home/home_page.dart';
import '../../routes/app_routes.dart';
import 'components/news_box_item.dart';
import 'news_box_controller.dart';

class BoxNews extends GetView<NewsBoxController> {
  const BoxNews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (listNews) {
        return Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 16, left: 16),
                child: const Text(
                  "Tin tức tài chính",
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
                  controller.setTag(controller.tabsId[index]);
                },
                tabs: controller.tabs
                    .map((e) => Tab(
                          text: e,
                        ))
                    .toList(),
              ),
              listNews == null || listNews.isEmpty
                  ? const Center(
                      child: Text("Không có dữ liệu"),
                    )
                  : Column(
                      children: [
                        ...listNews.take(3).toList().map((item) => BoxNewsItem(
                              newsDetail: item,
                            )),
                        // InkWell(
                        //   onTap: () => {Get.toNamed(AppRoutes.homeParent)},
                        //   child: Text(
                        //     "Xem thêm"
                        //   ),
                        // ),
                        GestureDetector(
                          onTap: () {
                            print('onTaponTap:');
                            // Navigator.pushNamed(context, "write your route");
                            Get.toNamed(AppRoutes.homeParent2);
                          },
                          onLongPress: () {
                            // open dialog OR navigate OR do what you want
                          },
                          child:
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 12,
                            ),child: const Text("Xem thêm",
                              style: TextStyle(color: Colors.lightBlue)),),
                        ),
                      ],
                    ),
            ],
          ),
        );
      },onLoading: Text('Đang tải dữ liệu')
    );
  }
}
