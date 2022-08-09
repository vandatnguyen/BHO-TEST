import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import 'controller/home_page_controller.dart';

class HomePageView extends GetView<HomePageController> {
  @override
  Widget build(BuildContext context) {
    return HomeApplicationFlow();
  }
}

// Just a standard StatefulWidget
class HomeApplicationFlow extends StatefulWidget {
  const HomeApplicationFlow({Key? key}) : super(key: key);

  @override
  _HomeApplicationFlowState createState() => _HomeApplicationFlowState();
}

// This is where the interesting stuff happens
class _HomeApplicationFlowState extends State<HomeApplicationFlow>
    with SingleTickerProviderStateMixin {
  // We need a TabController to control the selected tab programmatically
  late final _tabController = TabController(length: 4, vsync: this);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black38,
            ),
            onPressed: () {
              // do something
            },
          )
        ],
        backgroundColor: Colors.white,
        title: Image.asset('assets/images/FiNews.png',
            package: 'finews_module', width: 90, height: 16),
        titleSpacing: 0,
        leadingWidth: 8,
        // <-- Use this
        centerTitle: false,
        // <-- and this
        // Use TabBar to show the three tabs
        bottom: TabBar(
          isScrollable: true,
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 12,
          ),
          // padding: const EdgeInsets.all(16.0),
          labelColor: Colors.white,
          labelStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          unselectedLabelStyle:
              TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
          unselectedLabelColor: Colors.black,
          indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(10), // Creates border
              color: HexColor.fromHex('#58BD7D')),
          controller: _tabController,
          tabs: const <Widget>[
            Tab(
              text: 'Tất cả',
            ),
            Tab(
              text: 'Chứng khoán',
            ),
            Tab(
              text: 'Bất động sản',
            ),
            Tab(
              text: 'Doanh nghiệp',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          NewsPage(
            onNext: () => _tabController.index = 1,
          ),
          NewsPage(
            onNext: () => _tabController.index = 2,
          ),
          NewsPage(
            onNext: () => _tabController.index = 3,
          ),
          NewsPage(
            onNext: () => _tabController.index = 4,
          ),
        ],
      ),
    );
  }
}

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key, required this.onNext}) : super(key: key);
  final VoidCallback onNext;

  @override
  State<NewsPage> createState() => _NewsPageState();
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
  final String heading;

  HeadingItem(this.heading);

  @override
  Widget buildTitle(BuildContext context) {
    return const HotNewsItem();
  }

  @override
  Widget buildSubtitle(BuildContext context) => const SizedBox.shrink();

  @override
  Widget buildHorizontalListView(BuildContext context) =>
      const SizedBox.shrink();
}

class MessageItem implements ListItem {
  final String sender;
  final String body;

  MessageItem(this.sender, this.body);

  @override
  Widget buildTitle(BuildContext context) => const SizedBox.shrink();

  @override
  Widget buildSubtitle(BuildContext context) {
    return const NewsItem();
  }

  @override
  Widget buildHorizontalListView(BuildContext context) =>
      const SizedBox.shrink();
}

class HorizontalListViewItem implements ListItem {
  HorizontalListView() {}

  @override
  Widget buildTitle(BuildContext context) => const SizedBox.shrink();

  @override
  Widget buildSubtitle(BuildContext context) => const SizedBox.shrink();

  @override
  Widget buildHorizontalListView(BuildContext context) {
    return _horizontalListView();
  }
}

class NewsItem extends StatelessWidget {
  const NewsItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.centerStart,
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              color: Colors.black12,
              padding: const EdgeInsets.all(8),
              child: const Text(
                "BĐS",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 8,
              bottom: 12,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: 16,
                    ),
                    child: Text(
                      "Vietceramics khai trương showroom Him Lam Quận 7",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    "https://cdn.24h.com.vn/upload/3-2022/images/2022-08-06/Ket-qua-bong-da-Newcastle---Nottingham-Forest-Tan-cong-vu-bao-van-may-ngoanh-mat-Vong-1-Ngoai-hang-A-2022-08-06t152036z_510084302_up1ei8616m9li_rtrmadp-1659801557-88-width740height416.jpg",
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
                  children: const [
                    Text(
                      "CafeF",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                          fontSize: 13),
                    ),
                    TextWithIcon(
                      text: Text("14h trước"),
                      icon: Icon(
                        Icons.access_time,
                        size: 12,
                        color: Colors.black45,
                      ),
                    ),
                    TextWithIcon(
                      text: Text("23"),
                      icon: Icon(
                        Icons.chat,
                        size: 12,
                        color: Colors.black45,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.more_horiz_outlined,
                size: 16,
              )
            ],
          )
        ],
      ),
    );
  }
}

class TextWithIcon extends StatelessWidget {
  const TextWithIcon({
    Key? key,
    required this.text,
    this.icon,
  }) : super(key: key);

  final Text text;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 13),
      child: Row(
        children: [
          icon != null ? icon! : Container(),
          const VerticalDivider(
            width: 4,
          ),
          text,
        ],
      ),
    );
  }
}

class HotNewsItem extends StatelessWidget {
  const HotNewsItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 343 / 270,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 0,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                "https://cdnmedia.webthethao.vn/uploads/2022-06-14/chovy-mvp-gen.jpg",
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
                  children: const [
                    Text(
                      "CafeF",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                      child: Text(
                        "Cập nhật BCTC quý 2 ngày 27/7: Lợi nhuận PVS, HBC, Sacombank giảm, một công ty than gây bất ngờ lớn ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Text(
                      "26/07/2022 11:16",
                      style: TextStyle(
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
  const SubNewsItem({Key? key}) : super(key: key);

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
                "https://media-cdn-v2.laodong.vn/storage/newsportal/2022/8/8/1078607/Chung_Khoan_Hom_Nay-.jpg",
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
                      padding: EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                      child: Text(
                        "Quỹ tỷ USD do Dragon Capital quản lý nâng lượng tiền mặt nắm giữ lên cao nhất trong hơn 1 tháng",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Text(
                      "Vietstock 33 phút trước",
                      style: TextStyle(
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

class _NewsPageState extends State<NewsPage> {
  final items = List<ListItem>.generate(
    1000,
    (i) => i % 6 == 0
        ? HeadingItem('Heading $i')
        : i == 3
            ? HorizontalListViewItem()
            : MessageItem('Sender $i', 'Message body $i'),
  );

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // Let the ListView know how many items it needs to build.
      itemCount: items.length,
      // Provide a builder function. This is where the magic happens.
      // Convert each item into a widget based on the type of item it is.
      itemBuilder: (context, index) {
        final item = items[index];
        if (index == 3) {
          return item.buildHorizontalListView(context);
        }
        return ListTile(
          title: item.buildTitle(context),
          subtitle: item.buildSubtitle(context),
        );
      },
    );
  }
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

Widget _horizontalListView() {
  return Container(
      color: HexColor.fromHex('#F4F5F6'),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(
                left: 14,
                top: 14,
                right: 14,
                bottom: 4
              ),
              child: Row(
                children: [
                  Image.asset('assets/images/icon_stock.png',
                      package: 'finews_module', width: 24, height: 24),
                  const VerticalDivider(
                    width: 4,
                  ),
                  Text(
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
                itemCount: 15,
                itemBuilder: (context, index) {
                  return SubNewsItem();
                },
              ),
            ),
          ],
        ),
      ));
}
