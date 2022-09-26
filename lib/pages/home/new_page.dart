import 'package:cached_network_image/cached_network_image.dart';
import 'package:finews_module/configs/constants.dart';
import 'package:finews_module/cores/models/news_detail.dart';
import 'package:finews_module/pages/home/component/TextWithIcon.dart';
import 'package:finews_module/pages/home/home_page_controller.dart';
import 'package:finews_module/pages/list_news_route/list_news.dart';
import 'package:finews_module/routes/app_routes.dart';
import 'package:finews_module/shared_widgets/CustomRefresher.dart';
import 'package:finews_module/shared_widgets/ListNoDataBackground.dart';
import 'package:finews_module/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as time_ago;

class NewsPage extends GetView<HomePageController> {
  const NewsPage({Key? key, required this.onNext, required this.categoryId})
      : super(key: key);
  final VoidCallback onNext;
  final String categoryId;

  @override
  String? get tag => categoryId;

  @override
  Widget build(BuildContext context) {
    controller.categoryId = categoryId;
    return controller.obx(
      (state) => CustomRefresher(
        controller: controller.refreshController,
        onRefresh: controller.onRefresh,
        onLoading: controller.onLoadMore,
        child: ListView.builder(
          itemCount: state!.length,
          itemBuilder: (context, index) {
            if (state[index].type == 1) {
              return HeadingItem(state[0].model).buildTitle(context);
            }
            if (state[index].type == 2) {
              return HorizontalListViewItem(state[index].listNewsDetailModel)
                  .buildHorizontalListView(context);
            }
            final item = state[index];
            return MessageItem(item.model).buildSubtitle(context);
          },
        ),
      ),
      onLoading: ListNoDataBackground(
        padding: PAD_SYM_H40,
        pngPath: "assets/images/ic_no_data.png",
        title: "",
        desc: "Đang tải dữ liệu...",
        showIconButton: true,
        isLoading: true,
        onPressed: () => controller.onRefresh(),
      ),
      onError: (error) => ListNoDataBackground(
        padding: PAD_SYM_H40,
        showIconButton: true,
        btnTitle: "Thử lại",
        pngPath: "assets/images/ic_no_data.png",
        desc: "Có lỗi xảy ra, vui lòng thử lại",
        onPressed: () => controller.onRefresh(),
      ),
      onEmpty: ListNoDataBackground(
        padding: PAD_SYM_H40,
        showIconButton: true,
        btnTitle: "Thử lại",
        pngPath: "assets/images/ic_no_data.png",
        desc: "Có lỗi xảy ra, vui lòng thử lại",
        onPressed: () => controller.onRefresh(),
      ),
    );
  }
}

/// The base class for the different types of items the list can contain.
abstract class ListItem {
  /// The title line to show in a list item.
  Widget buildTitle(BuildContext context);

  /// The title line to show in a list item.
  Widget buildHorizontalListView(BuildContext context);

  /// The subtitle line, if any, to show in a list item.
  Widget buildSubtitle(BuildContext context);
}

/// A ListItem that contains data to display a heading.
class HeadingItem implements ListItem {
  final NewsDetailModel newsDetail;

  HeadingItem(this.newsDetail);

  @override
  Widget buildTitle(BuildContext context) {
    return InkWell(
        onTap: () {
          Get.toNamed(AppRoutes.newsDetail,
              arguments: {"news": newsDetail, "title": newsDetail.topicName});
        },
        child: HotNewsItem(newsDetail: newsDetail));
  }

  @override
  Widget buildSubtitle(BuildContext context) => const SizedBox.shrink();

  @override
  Widget buildHorizontalListView(BuildContext context) =>
      const SizedBox.shrink();
}

class MessageItem implements ListItem {
  final NewsDetailModel newsDetail;

  MessageItem(this.newsDetail);

  @override
  Widget buildTitle(BuildContext context) => const SizedBox.shrink();

  @override
  Widget buildSubtitle(BuildContext context) {
    return InkWell(
      child: Column(
        children: <Widget>[
          NewsItem(newsDetail: newsDetail),
          const Divider(),
        ],
      ),
      onTap: () {
        Get.toNamed(
          AppRoutes.newsDetail,
          arguments: {
            "news": newsDetail,
            "title": newsDetail.topicName,
          },
        );
      },
    );
  }

  @override
  Widget buildHorizontalListView(BuildContext context) =>
      const SizedBox.shrink();
}

class HorizontalListViewItem implements ListItem {
  final List<NewsDetailModel> listNewsDetailModel;

  HorizontalListViewItem(this.listNewsDetailModel);

  HorizontalListView() {}

  @override
  Widget buildTitle(BuildContext context) => const SizedBox.shrink();

  @override
  Widget buildSubtitle(BuildContext context) => const SizedBox.shrink();

  @override
  Widget buildHorizontalListView(BuildContext context) {
    return _horizontalListView(listNewsDetailModel);
  }
}

class NewsItem extends StatelessWidget {
  final NewsDetailModel newsDetail;
  final bool noPadding;

  const NewsItem({Key? key, required this.newsDetail, this.noPadding = false})
      : super(key: key);

  String? get tagName {
    try {
      var tags = newsDetail.tags;
      if (tags == null) {
        return null;
      }
      if (tags.isNotEmpty) {
        return tags[0];
      }
    } catch (e) {
      e.printError();
    }
    return null;
  }

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
    return Container(
      alignment: AlignmentDirectional.centerStart,
      padding: EdgeInsets.symmetric(
        vertical: 12,
        horizontal: !noPadding ? 12 : 0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              stockName != null
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
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          color: HexColor.fromHex('#58BD7D'),
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            stockName ?? "Nguồn",
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
              stockName != null
                  ? Container(
                      margin: const EdgeInsets.only(
                      top: 0,
                      right: 8,
                      bottom: 0,
                    ))
                  : const SizedBox.shrink(),
              InkWell(
                onTap: () {
                  Get.toNamed(
                    AppRoutes.listNews,
                    arguments: {
                      "item": newsDetail,
                      "type": ListNewsType.typeTag
                    },
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    color: HexColor.fromHex("#F2F4F7"),
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      newsDetail.topicName ?? "",
                      style: TextStyle(
                        fontSize: 13,
                        color: HexColor.fromHex("#8A8A8A"),
                      ),
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    height: 60,
                    width: 60,
                    fit: BoxFit.cover,
                    imageUrl: newsDetail.thumb,
                    placeholder: (context, url) => Transform.scale(
                      scale: 0.5,
                      child: const CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
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
                    Text(
                      newsDetail.sourceName ?? "",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: HexColor.fromHex("#858689"),
                          fontSize: 13),
                    ),
                    TextWithIcon(
                      text: Text(
                          time_ago.format(DateTime.fromMillisecondsSinceEpoch(
                              newsDetail.pubdate!)),
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: HexColor.fromHex("#858689"),
                              fontSize: 13)),
                      icon: const Icon(
                        Icons.access_time,
                        size: 12,
                        color: Colors.black45,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class HotNewsItem extends StatelessWidget {
  final NewsDetailModel newsDetail;

  const HotNewsItem({Key? key, required this.newsDetail}) : super(key: key);

  // const NewsItem({Key? key, required this.newsDetail}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 343 / 270,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 12,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(
                // height: 22,
                // width: 22,
                fit: BoxFit.cover,
                imageUrl: newsDetail.thumb,
                placeholder: (context, url) => Transform.scale(
                  scale: 0.5,
                  child: const CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [
                      Colors.grey.withOpacity(0.0),
                      Colors.black,
                    ],
                    stops: const [
                      0.0,
                      1.0,
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          newsDetail.sourceName!,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Image.asset(
                          "assets/images/dot.png",
                          package: "finews_module",
                          width: 4,
                          height: 4,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          newsDetail.topicName!,
                          style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                      child: Text(
                        newsDetail.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Text(
                      time_ago.format(DateTime.fromMillisecondsSinceEpoch(
                          newsDetail.pubdate!)),
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SubNewsItem extends StatelessWidget {
  final NewsDetailModel newsDetail;

  const SubNewsItem(this.newsDetail, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 306 / 190,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 12,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(
                // height: 22,
                // width: 22,
                fit: BoxFit.cover,
                imageUrl: newsDetail.thumb,
                placeholder: (context, url) => Transform.scale(
                  scale: 0.5,
                  child: const CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [
                      Colors.grey.withOpacity(0.0),
                      Colors.black,
                    ],
                    stops: const [
                      0.0,
                      1.0,
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    newsDetail.tags != null && newsDetail.tags!.isNotEmpty
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
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                      child: Text(
                        newsDetail.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          newsDetail.topicName!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Image.asset(
                          "assets/images/dot.png",
                          package: "finews_module",
                          width: 4,
                          height: 4,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          time_ago.format(DateTime.fromMillisecondsSinceEpoch(
                              newsDetail.pubdate!)),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget _horizontalListView(List<NewsDetailModel> listNewsDetailModel) {
  return Container(
      color: HexColor.fromHex('#F4F5F6'),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(
                  left: 14, top: 14, right: 14, bottom: 4),
              child: Row(
                children: [
                  Image.asset('assets/images/icon_stock.png',
                      package: 'finews_module', width: 24, height: 24),
                  const VerticalDivider(
                    width: 4,
                  ),
                  const Text(
                    "CHỨNG KHOÁN",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 220, // <-- you should put some value here
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: listNewsDetailModel.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    child: SubNewsItem(listNewsDetailModel[index]),
                    onTap: () {
                      Get.toNamed(AppRoutes.newsDetail, arguments: {
                        "news": listNewsDetailModel[index],
                        "title": listNewsDetailModel[index].topicName
                      });
                    },
                  );
                  // return SubNewsItem(listNewsDetailModel[index]);
                },
              ),
            ),
          ],
        ),
      ));
}
