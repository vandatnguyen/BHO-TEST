import 'package:finews_module/configs/colors.dart';
import 'package:finews_module/cores/services/news_api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as time_ago;

import '../../../../configs/constants.dart';
import '../../../../cores/models/comment_model.dart';

const fakeUrl =
    "https://thumbs.dreamstime.com/b/default-avatar-photo-placeholder-profile-icon-eps-file-easy-to-edit-default-avatar-photo-placeholder-profile-icon-124557887.jpg";

class CommentItem extends StatefulWidget {
  const CommentItem({
    Key? key,
    required this.commentModel,
    required this.likeComment,
    this.replyComment,
  }) : super(key: key);

  final CommentModel commentModel;
  final Function likeComment;
  final Function? replyComment;

  @override
  State<CommentItem> createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  final newServices = Get.find<NewsService>();
  final replyComments = <CommentModel>[].obs;

  Future<void> reloadReplyComment() async {
    try {
      var res = await newServices
          .getReplyComment(widget.commentModel.id?.toString() ?? "");
      replyComments(res.comments);
    } catch (e) {
      replyComments([]);
    }
  }

  @override
  void didUpdateWidget(covariant CommentItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.replyComment != null) {
      reloadReplyComment();
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    var likeWidget = InkWell(
      onTap: () {
        widget.likeComment();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(100),
          ),
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 0.5,
              blurRadius: 0.5,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.commentModel.numberLike?.toString() ?? "-1",
              style: const TextStyle(
                color: AppColors.color_474A57,
                fontSize: 11,
              ),
            ),
            SIZED_BOX_W02,
            const Icon(
              Icons.thumb_up_alt_outlined,
              size: 12,
            ),
          ],
        ),
      ),
    );

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.network(
                  fakeUrl,
                  height: 36,
                  width: 36,
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            width: width,
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              color: AppColors.color_F8F8F8,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  (widget.commentModel.userName ?? ""),
                                  style: const TextStyle(
                                    color: AppColors.color_777E90,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  widget.commentModel.content ?? "",
                                  style: const TextStyle(
                                    color: AppColors.color_23262F,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            child: likeWidget,
                            bottom: 0,
                            right: 10,
                          )
                        ],
                      ),
                      SIZED_BOX_H06,
                      Row(
                        children: [
                          Text(
                            time_ago.format(DateTime.fromMillisecondsSinceEpoch(
                                widget.commentModel.createdDate!)),
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              color: AppColors.color_777E90,
                              fontSize: 14,
                            ),
                          ),
                          widget.replyComment != null
                              ? GestureDetector(
                                  onTap: () {
                                    widget.replyComment!();
                                  },
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Text(
                                      "Trả lời",
                                      style: TextStyle(
                                          color: AppColors.color_141416,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14),
                                    ),
                                  ),
                                )
                              : const SizedBox(
                                  width: 10,
                                ),
                          GestureDetector(
                            child: const Text(
                              "Thích",
                              style: TextStyle(
                                  color: AppColors.color_141416,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14),
                            ),
                            onTap: () {
                              widget.likeComment();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          // Container(
          //   margin: EdgeInsets.only(left: 48),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       true
          //           ? Row(
          //               children: [
          //                 ImageIcon(const AssetImage(
          //                     "assets/images/ic_send_dis.png",
          //                     package: 'finews_module')),
          //                 Text("Xem thêm ${replyComments.length - 3} phản hồi"),
          //               ],
          //             )
          //           : Container(),
          //       ...replyComments.take(3).map((e) => Text("data")),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}
