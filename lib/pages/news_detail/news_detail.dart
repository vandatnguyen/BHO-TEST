import 'package:finews_module/pages/home/new_page.dart';
import 'package:finews_module/pages/news_detail/html_parser/html_parser.dart';
import 'package:finews_module/pages/news_detail/html_parser/html_parser_widget.dart';
import 'package:finews_module/pages/news_detail/news_detail_controller.dart';
import 'package:finews_module/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'component/NewsDetailFixedHeader.dart';
import 'component/NewsDetailFixedFooter.dart';
import 'component/NewsDetailFooter.dart';
import 'component/NewsDetailHeader.dart';
import 'component/NewsDetailStock.dart';
import 'component/NewsDetailTopRelated.dart';
import 'settings/NewsDetailSetting.dart';
import '../../cores/models/news_detail.dart';

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
          body: SingleChildScrollView(
            padding:
                const EdgeInsets.only(top: 0, bottom: 100, left: 16, right: 16),
            controller: controller.scrollController,
            child: Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                        NewsDetailHeader(
                            title: controller.model?.title ?? "",
                            sourceName: "Cafef",
                            date: controller.model?.formatDisplayDate() ?? ""),
                        if (controller.model?.stockInfo != null &&
                            (controller.model?.stockInfo?.length ?? 0) > 0)
                          NewsDetailStock(
                              model: controller.model!.stockInfo!.first)
                      ] +
                      controller.elements.value
                          .map((e) => e.buildWidget(context))
                          .toList() +
                      [
                        NewsDetailFooter(
                          originSrc: controller.model?.webUrl ?? "",
                          tags: controller.model?.tags ?? [],
                        ),
                        /*NewsDetailTopRelated()*/
                        Obx(() => ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.relativeNews.length,
                            itemBuilder: (context, index) => GestureDetector(
                                  onTap: () {
                                    Get.toNamed(AppRoutes.newsDetail,
                                        arguments: {
                                          "news":
                                              controller.relativeNews[index],
                                          "title": ""
                                        },
                                        preventDuplicates: false);
                                  },
                                  child: NewsItem(
                                      // horizontalPadding: 0,
                                      newsDetail:
                                          controller.relativeNews[index]),
                                )))
                      ],
                )),
          ),
        ),
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
        Container(
          alignment: Alignment.bottomCenter,
          child: SlideTransition(
              position: controller.offsetBottomAnimation,
              child: const NewsDetailFixedFooter()),
        )
      ]),
    );
  }
}
