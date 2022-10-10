import 'package:finews_module/configs/colors.dart';
import 'package:finews_module/cores/models/comment_model.dart';
import 'package:finews_module/pages/home/new_page.dart';
import 'package:finews_module/pages/news_detail/html_parser/html_parser_widget.dart';
import 'package:finews_module/pages/news_detail/news_detail_controller.dart';
import 'package:finews_module/routes/app_routes.dart';
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
import 'settings/NewsDetailSetting.dart';

const fakeId = "56:29:c469521d65d87257febedcdbb6d83915";

class NewsDetailPageView extends GetView<NewsDetailController> {
  NewsDetailPageView({Key? key}) : super(key: key);

  final newsService = Get.find<NewsService>();

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
    if (!Get.isRegistered<NewsDetailController>()) {
      Get.put(
          () => NewsDetailController(
              id: fakeId, pageTitle: Get.arguments["title"] ?? ""),
          tag: fakeId);
    }

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
                              var id = controller.id;

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
                                    articleId: id ?? fakeId,
                                  );
                                },
                              );
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
                                              likeComment: () async {
                                                await newsService.likeComment(
                                                    comment.id?.toString() ??
                                                        "");
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
                                                      parentCommentId:
                                                          comment.id.toString(),
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          )
                                    ],
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      controller.comments.isNotEmpty
                                          ? const Text(
                                              "Xem tất cả bình luận",
                                              style: TextStyle(
                                                  color:
                                                      AppColors.color_primary),
                                            )
                                          : const Text(
                                              "Chưa có bình luận nào",
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
      ]),
    );
  }
}

class BottomSheetComment extends StatefulWidget {
  const BottomSheetComment({Key? key, required this.articleId})
      : super(key: key);

  final String articleId;

  @override
  State<BottomSheetComment> createState() => _BottomSheetCommentState();
}

class _BottomSheetCommentState extends State<BottomSheetComment> {
  final textInputController = TextEditingController();

  final comments = <CommentModel>[].obs;
  final newServices = Get.find<NewsService>();

  @override
  void initState() {
    super.initState();
    reloadComment();
  }

  reloadComment() {
    newServices.getAllComment(widget.articleId).then((value) {
      comments(value.comments ?? []);
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    var paddingBot = MediaQuery.of(context).viewInsets.bottom;

    return SizedBox(
      height: height - 100,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(
                () => Text(
                  "Bình luận" +
                      (comments.length > 0 ? " (${comments.length})" : ""),
                  style: const TextStyle(
                    color: AppColors.color_777E90,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Obx(() => comments.isNotEmpty
                  ? ListView.builder(
                      itemBuilder: (context, i) {
                        var item = comments[i];
                        return CommentItem(
                          commentModel: item,
                          likeComment: () {
                            newServices.likeComment(item.id.toString());
                            reloadComment();
                          },
                          replyComment: () {
                            showModalBottomSheet(
                              isDismissible: true,
                              isScrollControlled: true,
                              backgroundColor: Colors.white,
                              context: context,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              builder: (builder) {
                                return ReplyBottomSheetComment(
                                  parentCommentId: item.id.toString(),
                                );
                              },
                            );
                          },
                        );
                      },
                      itemCount: comments.length,
                    )
                  : const Center(
                      child: Text("Chưa có bình luận nào"),
                    )),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: paddingBot),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: textInputController,
                      decoration: const InputDecoration(
                          hintText: "Để lại bình luận của bạn...",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  InkWell(
                    onTap: () async {
                      // post comment
                      var content = textInputController.text;
                      FocusManager.instance.primaryFocus?.unfocus();
                      try {
                        await newServices.comment(widget.articleId, content);
                        reloadComment();
                        textInputController.clear();
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: const SizedBox(
                      width: 30,
                      height: 30,
                      child: Icon(
                        Icons.send,
                        color: AppColors.color_primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReplyBottomSheetComment extends StatefulWidget {
  const ReplyBottomSheetComment({Key? key, required this.parentCommentId})
      : super(key: key);

  final String parentCommentId;

  @override
  State<ReplyBottomSheetComment> createState() =>
      _ReplyBottomSheetCommentState();
}

class _ReplyBottomSheetCommentState extends State<ReplyBottomSheetComment> {
  final textInputController = TextEditingController();
  final replyComments = <CommentModel>[].obs;
  final newServices = Get.find<NewsService>();

  @override
  void initState() {
    super.initState();
    reloadReplyComment();
  }

  reloadReplyComment() {
    newServices.getReplyComment(widget.parentCommentId).then((value) {
      replyComments(value.comments);
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    var paddingBot = MediaQuery.of(context).viewInsets.bottom;

    return SizedBox(
      height: height - 100,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Phản hồi",
                style: TextStyle(
                  color: AppColors.color_777E90,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Expanded(
              child: Obx(() => replyComments.isNotEmpty
                  ? ListView.builder(
                      itemBuilder: (context, i) {
                        var item = replyComments[i];
                        return CommentItem(
                          commentModel: item,
                          likeComment: () {
                            newServices.likeComment(item.id.toString());
                            reloadReplyComment();
                          },
                        );
                      },
                      itemCount: replyComments.length,
                    )
                  : const Center(
                      child: Text("Chưa có phản hồi nào"),
                    )),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: paddingBot),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: textInputController,
                      decoration: const InputDecoration(
                          hintText: "Để lại bình luận của bạn...",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  InkWell(
                    onTap: () async {
                      // post comment
                      var content = textInputController.text;
                      FocusManager.instance.primaryFocus?.unfocus();
                      try {
                        await newServices.replyComment(
                            widget.parentCommentId, content);
                        reloadReplyComment();
                        textInputController.clear();
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: const SizedBox(
                      width: 30,
                      height: 30,
                      child: Icon(
                        Icons.send,
                        color: AppColors.color_primary,
                      ),
                      //Icon(Icons.policy, color: foregroundColor),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
