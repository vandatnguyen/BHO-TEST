import 'package:finews_module/pages/home/new_page.dart';
import 'package:finews_module/pages/list_news_route/list_news_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../configs/colors.dart';
import '../../shared_widgets/CustomRefresher.dart';

enum ListNewsType { typeTag, typeStock }

class ListNewsView extends GetView<ListNewsController> {
  const ListNewsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
