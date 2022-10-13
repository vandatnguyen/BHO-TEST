import 'package:finews_module/configs/constants.dart';
import 'package:finews_module/finews_module.dart';
import 'package:finews_module/shared_widgets/ListNoDataBackground.dart';
import 'package:finews_module/theme/app_color.dart';
import 'package:finews_module/tracking/event_tracking.dart';
import 'package:finews_module/utils/extensions.dart';
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
    FiNewsModule.initNewsRouteAndBinding();
    EventManager().fire(EventTrackingWidgetAllView());
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        // physics: const NeverScrollableScrollPhysics(),
        // scrollDirection: Axis.vertical,
        // shrinkWrap: true,
        children: [
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(top: 12, left: 16),
            child: const Text(
              "Kinh tế tài chính",
              style: TextStyle(
                color: COLOR_333333,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Obx(
            () => TabBar(
              isScrollable: true,
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 12,
              ),
              labelColor: COLOR_333333,
              labelStyle: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w700,
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.normal,
              ),
              unselectedLabelColor: COLOR_858585,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  // Creates border
                  color: HexColor.fromHex('#F5F6FA')),
              controller: controller.tabController,
              onTap: (index) {
                controller.setTag(controller.tabsId[index]);
                EventManager().fire(EventTrackingWidgetAllClickTab(topicId: controller.tabsId[index]));
              },
              tabs: controller.tabsRx
                  .map((e) => Tab(
                        text: e,
                      ))
                  .toList(),
            ),
          ),
          controller.obx(
            (listNews) {
              int i = 0;
              return Container(
                decoration: const BoxDecoration(color: Colors.white),
                child: listNews == null || listNews.isEmpty
                    ? const Center(
                        child: Text("Không có dữ liệu"),
                      )
                    : Column(
                        children: [
                          ...listNews.take(2).toList().map((item) => Column(
                                children: [
                                  BoxNewsItem(
                                    newsDetail: item,
                                  ),
                                  i++ < 2
                                      ? const Divider()
                                      : const SizedBox.shrink()
                                ],
                              )),
                        ],
                      ),
              );
            },
            onLoading: ListNoDataBackground(
              padding: PAD_SYM_H40,
              pngPath: "assets/images/ic_no_data.png",
              title: "",
              desc: "Đang tải dữ liệu...",
              showIconButton: true,
              isLoading: true,
              onPressed: () => controller.onRefresh(),
            ),
            onError: (error) => ListNoDataBackground(
              padding: PAD_SYM_H40,
              showIconButton: true,
              btnTitle: "Thử lại",
              pngPath: "assets/images/ic_no_data.png",
              desc: "Có lỗi xảy ra, vui lòng thử lại",
              onPressed: () => controller.onRefresh(),
            ),
            onEmpty: ListNoDataBackground(
              padding: PAD_SYM_H40,
              showIconButton: true,
              btnTitle: "Thử lại",
              pngPath: "assets/images/ic_no_data.png",
              desc: "Có lỗi xảy ra, vui lòng thử lại",
              onPressed: () => controller.onRefresh(),
            ),
          ),
          Obx(() => GestureDetector(
                onTap: () {
                  print('onTaponTap:');
                  Get.toNamed(AppRoutes.homeParent2,
                      arguments: {"idSelected": controller.currentTag});
                  EventManager().fire(EventTrackingWidgetAllClickMore(topicId: controller.currentTag));
                },
                onLongPress: () {
                  // open dialog OR navigate OR do what you want
                },
                child: Container(
                  alignment: Alignment.center,
                  // width: double.infinity,
                  // color: Colors.lightBlue,
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 12,
                  ),
                  child: controller.tabsRx2.isNotEmpty
                      ? Text("Xem thêm",
                          style: TextStyle(
                              color: HexColor.fromHex("#2F80ED"), fontSize: 14))
                      : const SizedBox.shrink(),
                ),
              )),
        ],
      ),
    );
  }
}
