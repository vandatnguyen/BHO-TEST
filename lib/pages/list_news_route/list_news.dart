import 'package:finews_module/configs/constants.dart';
import 'package:finews_module/cores/models/news_detail.dart';
import 'package:finews_module/pages/home/new_page.dart';
import 'package:finews_module/pages/list_news_route/list_news_controller.dart';
import 'package:finews_module/shared_widgets/ListNoDataBackground.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../configs/colors.dart';
import '../../shared_widgets/CustomRefresher.dart';

enum ListNewsType { typeTag, typeStock }

class ListNewsView extends GetView<ListNewsController> {
  const ListNewsView({Key? key}) : super(key: key);

  @override
  String? get tag {
    try {
      NewsDetailModel detail = Get.arguments["item"];
      ListNewsType type = Get.arguments["type"];
      return detail.id + type.name;
    } catch (e) {
      print(e);
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    controller.refreshController = RefreshController();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 16,
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      size: 24,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        controller.title ?? "",
                        style: const TextStyle(
                          color: AppColors.color_18191F,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  SizedBox.fromSize(
                    size: const Size.square(24),
                  )
                ],
              ),
            ),
            // const Divider(),
            Expanded(
              child: controller.obx(
                (state) => CustomRefresher(
                  controller: controller.refreshController,
                  onRefresh: controller.onRefresh,
                  onLoading: controller.onLoad,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: state!.length,
                    itemBuilder: (context, index) {
                      final item = state[index];
                      return MessageItem(item).buildSubtitle(context);
                      // return NewsListItem(newsDetail: item,);
                    },
                  ),
                ),
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
            ),
          ],
        ),
      ),
    );
  }
}
