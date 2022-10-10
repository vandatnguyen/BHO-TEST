import 'package:finews_module/configs/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:timeago/timeago.dart' as time_ago;

import '../../../../cores/models/comment_model.dart';
import '../../../../utils/extensions.dart';

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
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      width: width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.network(
                fakeUrl,
                height: 36,
                width: 36,
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: width - 100,
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      color: AppColors.color_F8F8F8,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (widget.commentModel.userName ?? "") + " Like: " + (widget.commentModel.numberLike?.toString() ?? "-1"),
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
                  Row(
                    children: [
                      Text(
                        time_ago.format(DateTime.fromMillisecondsSinceEpoch(
                            widget.commentModel.createdDate!)),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: HexColor.fromHex("#858689"),
                          fontSize: 13,
                        ),
                      ),
                      widget.replyComment != null ?
                      GestureDetector(
                        onTap: () {
                          widget.replyComment!();
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text("Trả lời"),
                        ),
                      ) : Container(),
                      GestureDetector(
                        child: const Text("Thích"),
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
    );
  }
}
