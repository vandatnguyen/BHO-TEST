import 'package:finews_module/pages/news_detail/html_parser/html_parser.dart';
import 'package:finews_module/pages/news_detail/html_parser/html_parser_widget.dart';
import 'package:finews_module/pages/news_detail/news_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'component/NewsDetailFixedHeader.dart';
import 'component/NewsDetailFixedFooter.dart';
import 'component/NewsDetailFooter.dart';
import 'component/NewsDetailHeader.dart';
import 'component/NewsDetailStock.dart';
import 'component/NewsDetailTopRelated.dart'; 
import 'settings/NewsDetailSetting.dart';
 
class NewsDetailPageView extends GetView<NewsDetailController> {
  const NewsDetailPageView({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      body: Stack(children: [ Scaffold(
                  body: SingleChildScrollView(
                    padding: const EdgeInsets.only(
                        top: 0, bottom: 100, left: 16, right: 16),
                    controller: controller.scrollController,
                    child: Obx(()=>Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                            NewsDetailHeader(
                              title: controller.model?.title ?? "",
                              sourceName: "Chua co",
                              date: "00:00 00/00/0000"
                            ),
                            NewsDetailStock()
                          ] +
                          controller.elements.value
                              .map((e) => e.buildWidget(context))
                              .toList() +
                          [NewsDetailFooter(originSrc: controller.model?.webUrl ?? "", tags: controller.model?.tags ?? [],), NewsDetailTopRelated()],
                    )),
                  ),
                ),
        SlideTransition(
            position: controller.offsetAnimation,
            child: NewsDetailFixedHeader(
              title: controller.pageTitle,
              onBack: (){
                Get.back();
              },
              onBookmark: (){
                Get.snackbar(
                  "Hì! Bookmark",
                  "Chưa có tính năng này",
                ); 
              },
              onSetting: () {
                showModalBottomSheet(
                    isDismissible:  true,
                    isScrollControlled:  true,
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
