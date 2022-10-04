import 'package:finews_module/configs/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:timeago/timeago.dart' as time_ago;

import '../../../../cores/models/comment_model.dart';
import '../../../../utils/extensions.dart';

const fakeUrl =
    "https://lh3.googleusercontent.com/ogw/AOh-ky31lkjbkwoihMKRM9mY7xgcTRilbnQDjmxT9kli0Q=s64-c-mo";

class CommentItem extends StatelessWidget {
  const CommentItem({Key? key, required this.commentModel}) : super(key: key);

  final CommentModel commentModel;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Image.network(
              fakeUrl,
              height: 36,
              width: 36,
            ),
          ),
          Container(
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
                        commentModel.userName ?? "",
                        style: const TextStyle(
                          color: AppColors.color_777E90,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        commentModel.content ?? "",
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
                          commentModel.createdDate!)),
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: HexColor.fromHex("#858689"),
                        fontSize: 13,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text("Trả lời"),
                    ),
                    const Text("Thích"),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
