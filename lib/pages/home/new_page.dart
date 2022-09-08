import 'package:finews_module/cores/models/news_detail.dart';
import 'package:finews_module/pages/home/component/TextWithIcon.dart';
import 'package:finews_module/pages/home/home_page.dart';
import 'package:finews_module/pages/home/home_page_controller.dart';
import 'package:finews_module/routes/app_routes.dart';
import 'package:finews_module/shared_widgets/CustomRefresher.dart';
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
    return controller.obx((state) => CustomRefresher(
          controller: controller.refreshController,
          onRefresh: controller.onRefresh,
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
        ));
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
    return HotNewsItem(newsDetail: newsDetail);
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
    return GestureDetector(
      child: Column(
        children: <Widget>[
          NewsItem(newsDetail: newsDetail),
          const Divider(), //                           <-- Divider
        ],
      ),
      onTap: () {
        Get.toNamed(AppRoutes.newsDetail);
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

  const NewsItem({Key? key, required this.newsDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.newsDetail,
            arguments: {"news": newsDetail, "title": newsDetail.topicName});
      },
      child: Container(
        alignment: AlignmentDirectional.centerStart,
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                newsDetail.symbols != null && newsDetail.symbols!.length > 0
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          color: HexColor.fromHex('#58BD7D'),
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            newsDetail.symbols != null &&
                                    newsDetail.symbols!.length > 0
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
                newsDetail.symbols != null && newsDetail.symbols!.length > 0
                    ? Container(
                        margin: const EdgeInsets.only(
                        top: 0,
                        right: 8,
                        bottom: 0,
                      ))
                    : const SizedBox.shrink(),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    color: Colors.black12,
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      newsDetail.topicName!,
                      // newsDetail.tags != null && newsDetail.tags!.length > 0
                      //     ? newsDetail.tags![0]
                      //     : "Tin tức",
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
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      newsDetail.thumb,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
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
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                            fontSize: 13),
                      ),
                      TextWithIcon(
                        // text: Text(''),
                        text: Text(time_ago.format(
                            DateTime.fromMillisecondsSinceEpoch(
                                newsDetail.pubdate!))),
                        icon: const Icon(
                          Icons.access_time,
                          size: 12,
                          color: Colors.black45,
                        ),
                      ),
                      // TextWithIcon(
                      //   text: Text("0"),
                      //   icon: Icon(
                      //     Icons.chat,
                      //     size: 12,
                      //     color: Colors.black45,
                      //   ),
                      // ),
                    ],
                  ),
                ),
                // const Icon(
                //   Icons.more_horiz_outlined,
                //   size: 16,
                // )
              ],
            )
          ],
        ),
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
              Image.network(
                newsDetail.thumb,
                fit: BoxFit.cover,
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
                    Text(
                      newsDetail.sourceName!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontSize: 13,
                      ),
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
              Image.network(
                newsDetail.thumb,
                fit: BoxFit.cover,
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
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        color: HexColor.fromHex('#58BD7D'),
                        padding: const EdgeInsets.all(8),
                        child: const Text(
                          "ANV",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                          ),
                        ),
                      ),
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
                      newsDetail.topicName! +
                          " " +
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
                  return SubNewsItem(listNewsDetailModel[index]);
                },
              ),
            ),
          ],
        ),
      ));
}
