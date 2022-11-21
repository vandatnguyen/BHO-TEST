import 'package:finews_module/app/modules/comment_list/views/comment_list_view.dart';
import 'package:finews_module/configs/colors.dart';
import 'package:finews_module/configs/constants.dart';
import 'package:finews_module/data/entities/currency_model.dart';
import 'package:finews_module/data/entities/gold_model.dart';
import 'package:finews_module/pages/home/new_page.dart';
import 'package:finews_module/pages/news_detail/html_parser/html_parser_widget.dart';
import 'package:finews_module/pages/news_detail/news_detail_controller.dart';
import 'package:finews_module/pages/news_detail/settings/NewsDetailSetting.dart';
import 'package:finews_module/routes/app_routes.dart';
import 'package:finews_module/shared_widgets/auto_vertical_scroll_view_view.dart';
import 'package:finews_module/shared_widgets/currency_item_view.dart';
import 'package:finews_module/shared_widgets/gold_item_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../cores/models/news_detail.dart';
import '../../cores/services/news_api_service.dart';
import 'component/NewsDetailFixedHeader.dart';
import 'component/NewsDetailFooter.dart';
import 'component/NewsDetailHeader.dart';
import 'component/NewsDetailStock.dart';
import 'component/comment/comment_item.dart';
import 'component/news_detail_error_widget.dart';

const fakeId = "56:29:c469521d65d87257febedcdbb6d83915";

class NewsDetailPageView extends GetView<NewsDetailController> {
  NewsDetailPageView({Key? key}) : super(key: key);

  final newsService = Get.find<NewsService>();

  String? id;

  @override
  String? get tag {
    if (id == null) {
      if (Get.arguments != null && Get.arguments["news"] is NewsDetailModel) {
        NewsDetailModel item = Get.arguments["news"] as NewsDetailModel;
        id = item.id;
        return item.id;
      } else if (Get.arguments != null && Get.arguments["id"] is String) {
        String id = Get.arguments["id"] as String;
        id = id;
        return id;
      }
    } else {}
    return id;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

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
                            date: controller.model?.formatDisplayDate() ?? "",
                            desc: controller.model?.desc ?? "",
                          ),
                          Obx(
                            () => AutoVerticalScrollView(
                              listItem: controller.listGoldRes.value?.values,
                              renderItem: (GoldModel item) {
                                return GoldItemView(item: item);
                              },
                            ),
                          ),
                          Obx(
                            () => AutoVerticalScrollView(
                              listItem: controller.listCurrencyRes.value?.value,
                              renderItem: (CurrencyModel item) {
                                return CurrencyItemView(item: item);
                              },
                            ),
                          ),
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
                              var id = controller.id;

                              // Get.toNamed(AppRoutes.commentListView, arguments: {
                              //   "articleId": id ?? fakeId
                              // });

                              if (id == null) {
                                return;
                              }

                              showModalBottomSheet(
                                isDismissible: true,
                                isScrollControlled: true,
                                backgroundColor: Colors.white,
                                context: context,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                builder: (builder) {
                                  return BottomSheetComment(
                                    articleId: id,
                                  );
                                },
                              ).whenComplete(() {
                                controller.loadComment();
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
                                      RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                            text:
                                                "Bình luận (${controller.comments.length})",
                                            style: const TextStyle(
                                              color: AppColors.color_777E90,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ]),
                                      ),
                                      SIZED_BOX_H12,
                                      ...controller.comments.take(3).map(
                                            (comment) => CommentItem(
                                              commentModel: comment,
                                              likeComment: () async {
                                                await newsService.likeComment(
                                                    comment.id?.toString() ??
                                                        "");
                                                await Future.delayed(
                                                    const Duration(seconds: 1));
                                                await controller.loadComment();
                                              },
                                              replyComment: () {
                                                showModalBottomSheet(
                                                  isDismissible: true,
                                                  isScrollControlled: true,
                                                  backgroundColor: Colors.white,
                                                  context: context,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  builder: (builder) {
                                                    return ReplyBottomSheetComment(
                                                      parentComment: comment,
                                                    );
                                                  },
                                                ).whenComplete(() {
                                                  controller.loadComment();
                                                });
                                              },
                                            ),
                                          )
                                    ],
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 12,
                                          horizontal: 24,
                                        ),
                                        child: controller.comments.isNotEmpty
                                            ? const Text(
                                                "Xem tất cả bình luận",
                                                style: TextStyle(
                                                    color: AppColors
                                                        .color_primary),
                                              )
                                            : const Text(
                                                "Chưa có bình luận nào",
                                              ),
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
              title: controller.pageTitle ?? "",
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
      ]),
    );
  }
}
