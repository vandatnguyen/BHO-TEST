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
    return Scaffold(
      body: Stack(children: [
        Scaffold(
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
                          sourceName: controller.model!.sourceName ?? "",
                          date: controller.model?.formatDisplayDate() ?? ""),
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
                        delegate: SliverChildBuilderDelegate((context, index) {
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
                    SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
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
