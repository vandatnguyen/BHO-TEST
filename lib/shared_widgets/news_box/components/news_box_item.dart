import 'package:cached_network_image/cached_network_image.dart';
import 'package:finews_module/cores/models/news_detail.dart';
import 'package:finews_module/pages/home/component/TextWithIcon.dart';
import 'package:finews_module/pages/home/home_page.dart';
import 'package:finews_module/pages/list_news_route/list_news.dart';
import 'package:finews_module/routes/app_routes.dart';
import 'package:finews_module/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as time_ago;

class BoxNewsItem extends StatelessWidget {
  final NewsDetailModel newsDetail;

  const BoxNewsItem({Key? key, required this.newsDetail}) : super(key: key);

  String? get stockName {
    try {
      var symbols = newsDetail.symbols;
      if (symbols == null) {
        return null;
      }
      if (symbols.isNotEmpty) {
        return symbols[0];
      }
    } catch (e) {
      e.printError();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.newsDetail,
            arguments: {"news": newsDetail, "title": newsDetail.topicName});
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
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
                            stockName != null && stockName!.isNotEmpty
                                ? InkWell(
                                    onTap: () {
                                      Get.toNamed(
                                        AppRoutes.listNews,
                                        arguments: {
                                          "item": newsDetail,
                                          "type": ListNewsType.typeStock,
                                        },
                                      );
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(14),
                                      child: Container(
                                        color: HexColor.fromHex('#58BD7D'),
                                        padding: const EdgeInsets.all(8),
                                        child: Text(
                                          stockName != null &&
                                                  stockName!.isNotEmpty
                                              ? stockName!
                                              : "",
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.white,
                                          ),
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
                            newsDetail.topicName != null && newsDetail.topicName!.isNotEmpty ? InkWell(
                              onTap: () {
                                Get.toNamed(
                                  AppRoutes.listNews,
                                  arguments: {
                                    "item": newsDetail,
                                    "type": ListNewsType.typeSym
                                  },
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(43),
                                child: Container(
                                  color: HexColor.fromHex("#F2F4F7"),
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    newsDetail.topicName!,
                                    style: TextStyle(
                                        color: HexColor.fromHex("#8A8A8A"),
                                        fontSize: 13),
                                  ),
                                ),
                              ),
                            ) : SizedBox.shrink(),
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
                                    style: context.textSize16.copyWith(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      height: 75,
                      width: 105,
                      fit: BoxFit.cover,
                      imageUrl: newsDetail.thumb,
                      placeholder: (context, url) => Transform.scale(
                        scale: 0.5,
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    )
                    // Image.network(
                    //   newsDetail.thumb,
                    //   width: 117,
                    //   height: 117,
                    //   fit: BoxFit.cover,
                    // ),
                    ),
              ],
            ),
            Row(
              children: [
                CachedNetworkImage(
                  height: 22,
                  width: 22,
                  fit: BoxFit.cover,
                  imageUrl: newsDetail.sourceIconUrl ?? "",
                  placeholder: (context, url) => Transform.scale(
                    scale: 0.5,
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    newsDetail.sourceName ??
                    "",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: HexColor.fromHex("#858689"),
                        fontSize: 13,
                        overflow: TextOverflow.ellipsis),
                  ),
                ),
                // Expanded(
                //   child:
                TextWithIcon(
                  text: Text(
                    time_ago.format(
                      DateTime.fromMillisecondsSinceEpoch(
                        newsDetail.pubdate!,
                      ),
                    ),
                    style: TextStyle(
                        color: HexColor.fromHex("#858689"), fontSize: 12),
                  ),
                  icon: const Icon(
                    Icons.access_time,
                    size: 12,
                    color: Colors.black45,
                  ),
                ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
