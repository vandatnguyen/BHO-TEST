import 'dart:math' as math;

import 'package:finews_module/configs/colors.dart';
import 'package:finews_module/cores/models/comment_model.dart';
import 'package:finews_module/cores/services/news_api_service.dart';
import 'package:finews_module/pages/news_detail/component/comment/comment_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/comment_list_controller.dart';

class CommentListView extends GetView<CommentListController> {
  const CommentListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
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

  openBottomSheetReply(CommentModel parentComment) {
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
          parentComment: parentComment,
        );
      },
    ).whenComplete(() {
      reloadComment();
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: ValueListenableBuilder(
        valueListenable: textInputController,
        builder: (context, value, child) => SafeArea(
          child: SizedBox(
            height: height - 300,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
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
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: const Text(
                                "Đóng",
                                style: TextStyle(
                                  color: AppColors.color_23262F,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
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
                                  var replyList = item.replys?.comments ?? [];

                                  var shouldShowExpandReply =
                                      replyList.length > 3;

                                  return Column(
                                    children: [
                                      CommentItem(
                                        commentModel: item,
                                        likeComment: () async {
                                          await newServices
                                              .likeComment(item.id.toString());
                                          await Future.delayed(
                                              const Duration(seconds: 1));
                                          await reloadComment();
                                        },
                                        replyComment: () {
                                          openBottomSheetReply(item);
                                        },
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          openBottomSheetReply(item);
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.only(left: 50),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              shouldShowExpandReply
                                                  ? Text(
                                                      "Xem thêm ${replyList.length - 3} phản hồi",
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 16,
                                                        color: AppColors
                                                            .color_141416,
                                                      ),
                                                    )
                                                  : Container(),
                                              ...?item.replys?.comments
                                                  .take(3)
                                                  .map(
                                                    (childComment) => CommentItem(
                                                      commentModel: childComment,
                                                      likeComment: () async {
                                                        await newServices
                                                            .likeComment(
                                                                childComment.id
                                                                    .toString());
                                                        await Future.delayed(
                                                            const Duration(
                                                                seconds: 1));
                                                        await reloadComment();
                                                      },
                                                    ),
                                                  ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                },
                                itemCount: comments.length,
                              )
                            : const Center(
                                child: Text("Chưa có bình luận nào",style: TextStyle(
                                  fontSize: 14,
                                )),
                              )),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(100),
                        ),
                        color: AppColors.color_F4F5F7,
                        border: Border.all(color: AppColors.color_EEEFF4),
                      ),
                      child: Row(
                        children: <Widget>[
                          const SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: TextField(
                              textCapitalization: TextCapitalization.sentences,
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
                                if (kDebugMode) {
                                  print(e);
                                }
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
                              padding: const EdgeInsets.all(16),
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
        ),
      ),
    );
  }
}

class ReplyBottomSheetComment extends StatefulWidget {
  const ReplyBottomSheetComment({Key? key, required this.parentComment})
      : super(key: key);

  final CommentModel parentComment;

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
      var res = await newServices
          .getReplyComment(widget.parentComment.id?.toString() ?? "");
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
    var height = MediaQuery.of(context).size.height;

    var parentId = widget.parentComment.id;

    if (parentId == null) {
      return Container();
    }

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: ValueListenableBuilder(
        valueListenable: textInputController,
        builder: (context, value, child) => SizedBox(
          height: height - 64,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    child: Stack(
                      children: [
                        Positioned(
                          child: Align(
                            alignment: Alignment.center,
                            child: RichText(
                              text: TextSpan(children: [
                                const TextSpan(
                                  text: "Phản hồi ",
                                  style: TextStyle(
                                    color: AppColors.color_18191F,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextSpan(
                                  text: "(${replyComments.length})",
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
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: const Text(
                                "Đóng",
                                style: TextStyle(
                                    color: AppColors.color_23262F,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  CommentItem(
                      commentModel: widget.parentComment, likeComment: () {}),
                  Expanded(
                    child: _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Obx(() => replyComments.isNotEmpty
                            ? Container(
                                margin: const EdgeInsets.only(left: 50),
                                child: ListView.builder(
                                  itemBuilder: (context, i) {
                                    var item = replyComments[i];
                                    return CommentItem(
                                      commentModel: item,
                                      likeComment: () {
                                        newServices
                                            .likeComment(item.id.toString());
                                        reloadReplyComment();
                                      },
                                    );
                                  },
                                  itemCount: replyComments.length,
                                ),
                              )
                            : const Center(
                                child: Text("Chưa có phản hồi nào"),
                              )),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(100),
                        ),
                        color: AppColors.color_F4F5F7,
                        border: Border.all(color: AppColors.color_EEEFF4),
                      ),
                      child: Row(
                        children: <Widget>[
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: TextField(
                              textCapitalization: TextCapitalization.sentences,
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
                                    parentId.toString(), content);
                                reloadReplyComment();
                                textInputController.clear();
                              } catch (e) {
                                if (kDebugMode) {
                                  print(e);
                                }
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
        ),
      ),
    );
  }
}
