import 'package:finews_module/cores/models/news_detail.dart';
import 'package:finews_module/pages/home/component/TextWithIcon.dart';
import 'package:finews_module/pages/home/home_page.dart';
import 'package:finews_module/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as time_ago;

class BoxNewsItem extends StatelessWidget {
  final NewsDetailModel newsDetail;

  const BoxNewsItem({Key? key, required this.newsDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.newsDetail,
            arguments: {"news": newsDetail, "title": newsDetail.topicName});
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: Container(
                alignment: AlignmentDirectional.centerStart,
                padding: const EdgeInsets.only(right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        newsDetail.symbols != null &&
                                newsDetail.symbols!.isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Container(
                                  color: HexColor.fromHex('#58BD7D'),
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    newsDetail.symbols != null &&
                                            newsDetail.symbols!.isNotEmpty
                                        ? newsDetail.symbols![0]
                                        : "Nguồn",
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                        newsDetail.symbols != null &&
                                newsDetail.symbols!.isNotEmpty
                            ? Container(
                                margin: const EdgeInsets.only(
                                top: 0,
                                right: 8,
                                bottom: 0,
                              ))
                            : const SizedBox.shrink(),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(43),
                          child: Container(
                            color: Colors.black12,
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              newsDetail.topicName!,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 8,
                        bottom: 12,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                right: 16,
                              ),
                              child: Text(
                                newsDetail.title,
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Image.network(
                                newsDetail.sourceIconUrl ?? "",
                                height: 22,
                                width: 22,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                newsDetail.sourceName ?? "",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                  fontSize: 13,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        TextWithIcon(
                          text: Text(
                            time_ago.format(
                              DateTime.fromMillisecondsSinceEpoch(
                                newsDetail.pubdate!,
                              ),
                            ),
                          ),
                          icon: const Icon(
                            Icons.access_time,
                            size: 12,
                            color: Colors.black45,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                newsDetail.thumb,
                width: 117,
                height: 117,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
