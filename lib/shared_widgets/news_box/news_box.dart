import 'package:finews_module/configs/constants.dart';
import 'package:finews_module/shared_widgets/ListNoDataBackground.dart';
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
              vertical: 10,
              horizontal: 12,
            ),
            labelColor: COLOR_333333,
            labelStyle: const TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w700,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 12.0,
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
          controller.obx(
            (listNews) {
              return Container(
                decoration: const BoxDecoration(color: Colors.white),
                child: listNews == null || listNews.isEmpty
                    ? const Center(
                        child: Text("Không có dữ liệu"),
                      )
                    : Column(
                        children: [
                          ...listNews
                              .take(3)
                              .toList()
                              .map((item) => BoxNewsItem(
                                    newsDetail: item,
                                  )),
                        ],
                      ),
              );
            },
            onLoading: ListNoDataBackground(
              padding: PAD_SYM_H40,
              pngPath: "assets/images/ic_no_data.png",
              title: "",
              desc: "",
              btnTitle: "Thử lại",
              showIconButton: true,
              isLoading: true,
              onPressed: () => controller.onRefresh(),
            ),
            onError: (error) => ListNoDataBackground(
              padding: PAD_SYM_H40,
              showIconButton: true,
              btnTitle: "Thử lại",
              pngPath: "assets/images/ic_no_data.png",
              desc: "Đã có lỗi xảy ra, vui lòng thử lại",
              onPressed: () => controller.onRefresh(),
            ),
            onEmpty: ListNoDataBackground(
              padding: PAD_SYM_H40,
              showIconButton: true,
              btnTitle: "Thử lại",
              pngPath: "assets/images/ic_no_data.png",
              desc: "Đã có lỗi xảy ra, vui lòng thử lại",
              onPressed: () => controller.onRefresh(),
            ),
          ),
          GestureDetector(
            onTap: () {
              print('onTaponTap:');
              // Navigator.pushNamed(context, "write your route");
              Get.toNamed(AppRoutes.homeParent2);
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
              child: Text("Xem thêm",
                  style: TextStyle(
                      color: HexColor.fromHex("#2F80ED"), fontSize: 14)),
            ),
          )
        ],
      ),
    );
  }
}
