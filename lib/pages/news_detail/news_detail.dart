import 'dart:convert';

import 'package:finews_module/configs/colors.dart';
import 'package:finews_module/pages/home/new_page.dart';
import 'package:finews_module/pages/news_detail/html_parser/html_parser_widget.dart';
import 'package:finews_module/pages/news_detail/news_detail_controller.dart';
import 'package:finews_module/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../cores/models/news_detail.dart';
import 'component/NewsDetailFixedHeader.dart';
import 'component/NewsDetailFooter.dart';
import 'component/NewsDetailHeader.dart';
import 'component/NewsDetailStock.dart';
import 'component/comment/comment_item.dart';
import 'component/news_detail_error_widget.dart';
import 'settings/NewsDetailSetting.dart';

class NewsDetailPageView extends GetView<NewsDetailController> {
  const NewsDetailPageView({Key? key}) : super(key: key);

  @override
  String? get tag {
    if (Get.arguments != null && Get.arguments["news"] is NewsDetailModel) {
      NewsDetailModel item = Get.arguments["news"] as NewsDetailModel;
      return item.id;
    } else if (Get.arguments != null && Get.arguments["id"] is String) {
      String id = Get.arguments["id"] as String;
      return id;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    //Get.put(NewsDetailController(pageTitle: ''));
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding:
                  const EdgeInsets.only(top: 0, bottom: 0, left: 16, right: 16),
              child: Obx(() => CustomScrollView(
                      /*  padding:
                const EdgeInsets.only(top: 0, bottom: 100, left: 16, right: 16),*/
                      controller: controller.scrollController,
                      slivers: [
                        SliverList(
                            delegate: SliverChildListDelegate.fixed([
                          NewsDetailHeader(
                              title: controller.model?.title ?? "",
                              sourceName: controller.model?.sourceName ?? "",
                              date:
                                  controller.model?.formatDisplayDate() ?? ""),
                          if (controller.model?.stockInfo != null &&
                              (controller.model?.stockInfo?.length ?? 0) > 0)
                            NewsDetailStock(
                                model: controller.model!.stockInfo!.first),
                          Obx(() => (controller.error.value != null)
                              ? NewsDetailErrorWidget(
                                  onTap: () {
                                    controller.loadContent();
                                  },
                                  error: controller.error.value!,
                                )
                              : const SizedBox())
                        ])),
                        SliverList(
                            delegate:
                                SliverChildBuilderDelegate((context, index) {
                          return controller.elements
                              .elementAt(index)
                              .buildWidget(context);
                        }, childCount: controller.elements.length)),
                        SliverToBoxAdapter(
                          child: NewsDetailFooter(
                            originSrc: controller.model?.url ?? "",
                            tags: controller.model?.tags ?? [],
                            onTapSource: () {
                              Get.toNamed(AppRoutes.newsWebview, parameters: {
                                "link": controller.model?.url ?? "",
                                "title": controller.model?.title ?? ""
                              });
                            },
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: GestureDetector(
                            onTap: () {
                              var comments = controller.comments;
                              showModalBottomSheet(
                                  isDismissible: true,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (builder) {
                                    return Container();
                                  });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Column(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Bình luận",
                                        style: TextStyle(
                                          color: AppColors.color_777E90,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      ...controller.comments.take(3).map(
                                            (comment) => CommentItem(
                                              commentModel: comment,
                                            ),
                                          )
                                    ],
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      const Text(
                                        "Xem tất cả bình luận",
                                        style: TextStyle(
                                            color: AppColors.color_primary),
                                      ),
                                      Container(
                                        width: width,
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 8,
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 20,
                                        ),
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(19)),
                                          color: AppColors.color_F8F8F8,
                                        ),
                                        child: const Text(
                                          "Để lại bình luận của bạn...",
                                          style: TextStyle(
                                              color: AppColors.color_777E90),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SliverList(
                            delegate:
                                SliverChildBuilderDelegate((context, index) {
                          return InkWell(
                              onTap: () {
                                Get.toNamed(
                                  AppRoutes.newsDetail,
                                  arguments: {
                                    "news": controller.relativeNews[index],
                                    "title":
                                        controller.relativeNews[index].topicName
                                  },
                                  preventDuplicates: false,
                                );
                              },
                              child: Column(children: <Widget>[
                                NewsItem(
                                  newsDetail: controller.relativeNews[index],
                                  noPadding: true,
                                ),
                                const Divider()
                              ]));
                        }, childCount: controller.relativeNews.value.length))
                      ])),
            )),
        SlideTransition(
            position: controller.offsetAnimation,
            child: NewsDetailFixedHeader(
              title: controller.pageTitle,
              onBack: () {
                Get.back();
              },
              onBookmark: () {},
              onSetting: () {
                showModalBottomSheet(
                    isDismissible: true,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (builder) => NewsDetailSetting());
              },
            )),
        // Container(
        //   alignment: Alignment.bottomCenter,
        //   child: SlideTransition(
        //       position: controller.offsetBottomAnimation,
        //       child: const NewsDetailFixedFooter()),
        // )
      ]),
    );
  }
}
