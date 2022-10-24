import 'dart:math' as math;

import 'package:finews_module/configs/colors.dart';
import 'package:finews_module/cores/models/comment_model.dart';
import 'package:finews_module/cores/services/news_api_service.dart';
import 'package:finews_module/pages/news_detail/component/comment/comment_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../pages/news_detail/news_detail.dart';
import '../controllers/comment_list_controller.dart';

class CommentListView extends GetView<CommentListController> {
  const CommentListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final articleId = fakeId;
    return Scaffold(
      body: BottomSheetComment(
        articleId: articleId,
      ),
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

  bool _isLoading = false;

  Future<void> reloadComment() async {
    try {
      setState(() {
        _isLoading = true;
      });
      var res = await newServices.getAllComment(widget.articleId);
      comments(res.comments);
    } catch (e) {
      comments([]);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var paddingBot = MediaQuery.of(context).viewInsets.bottom;
    var width = MediaQuery.of(context).size.width;

    return ValueListenableBuilder(
      valueListenable: textInputController,
      builder: (context, value, child) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                width: width,
                child: Stack(
                  children: [
                    Positioned(
                      child: Align(
                        alignment: Alignment.center,
                        child: RichText(
                          text: TextSpan(children: [
                            const TextSpan(
                              text: "Bình luận ",
                              style: TextStyle(
                                color: AppColors.color_18191F,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: "(${comments.length})",
                              style: const TextStyle(
                                color: AppColors.color_777E90,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ),
                    Positioned(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(Icons.arrow_back),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Obx(() => comments.isNotEmpty
                        ? ListView.builder(
                            itemBuilder: (context, i) {
                              var item = comments[i];
                              return CommentItem(
                                commentModel: item,
                                likeComment: () async {
                                  await newServices
                                      .likeComment(item.id.toString());
                                  await Future.delayed(
                                      const Duration(seconds: 1));
                                  await reloadComment();
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
              Container(
                padding: EdgeInsets.only(bottom: paddingBot),
                margin: const EdgeInsets.symmetric(vertical: 12),
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(100),
                    ),
                    color: AppColors.color_F8F8F8,
                  ),
                  child: Row(
                    children: <Widget>[
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: TextField(
                          onChanged: (String newStr) {},
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
                          if (content.isEmpty) {
                            return;
                          }
                          FocusManager.instance.primaryFocus?.unfocus();
                          try {
                            await newServices.comment(
                                widget.articleId, content);
                            reloadComment();
                            textInputController.clear();
                          } catch (e) {
                            print(e);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(100),
                            ),
                            color: textInputController.value.text.isNotEmpty
                                ? AppColors.color_primary
                                : AppColors.color_primary_fade_30,
                          ),
                          padding: const EdgeInsets.all(14),
                          child: Row(
                            children: [
                              Transform.rotate(
                                angle: -math.pi / 4,
                                child: const Icon(
                                  Icons.send_rounded,
                                  color: AppColors.white,
                                  size: 14,
                                ),
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              textInputController.value.text.isNotEmpty
                                  ? const Text(
                                      "GỬI",
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
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
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    reloadReplyComment();
  }

  reloadReplyComment() async {
    try {
      setState(() {
        _isLoading = true;
      });
      var res = await newServices.getReplyComment(widget.parentCommentId);
      replyComments(res.comments);
    } catch (e) {
      replyComments([]);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    var paddingBot = MediaQuery.of(context).viewInsets.bottom;

    return ValueListenableBuilder(
      valueListenable: textInputController,
      builder: (context, value, child) => SizedBox(
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
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Obx(() => replyComments.isNotEmpty
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
              Container(
                padding: EdgeInsets.only(bottom: paddingBot),
                margin: const EdgeInsets.symmetric(vertical: 12),
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(100),
                    ),
                    color: AppColors.color_F8F8F8,
                  ),
                  child: Row(
                    children: <Widget>[
                      const SizedBox(
                        width: 12,
                      ),
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
                          if (content.isEmpty) {
                            return;
                          }
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
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(100),
                            ),
                            color: textInputController.value.text.isNotEmpty
                                ? AppColors.color_primary
                                : AppColors.color_primary_fade_30,
                          ),
                          padding: const EdgeInsets.all(14),
                          child: Row(
                            children: [
                              Transform.rotate(
                                angle: -math.pi / 4,
                                child: const Icon(
                                  Icons.send_rounded,
                                  color: AppColors.white,
                                  size: 14,
                                ),
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              textInputController.value.text.isNotEmpty
                                  ? const Text(
                                      "GỬI",
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
