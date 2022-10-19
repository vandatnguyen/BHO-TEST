import 'package:finews_module/configs/constants.dart';
import 'package:finews_module/finews_module.dart';
import 'package:finews_module/shared_widgets/CustomRefresher.dart';
import 'package:finews_module/shared_widgets/ListNoDataBackground.dart';
import 'package:finews_module/theme/app_color.dart';
import 'package:finews_module/tracking/event_tracking.dart';
import 'package:finews_module/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../pages/home/home_page.dart';
import '../../routes/app_routes.dart';
import 'components/news_box_item.dart';
import 'news_box_controller.dart';
import 'news_stock_box_controller.dart';

class BoxStockNews extends GetView<NewsStockBoxController> {
  String stockName;

  BoxStockNews(this.stockName, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FiNewsModule.initNewsRouteAndBinding();
    EventManager().fire(EventTrackingWidgetAllView());
    controller.stockName = stockName;
    controller.initWebsite();
    return controller.obx(
          (listNews) => CustomRefresher(
        controller: controller.refreshController,
        onRefresh: controller.onRefresh,
        onLoading: controller.onLoad,
        child: ListView.builder(
          // physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: listNews!.length,
          itemBuilder: (context, index) {
            final item = listNews[index];
            return BoxNewsItem(
              newsDetail: item,
            );
            // return NewsListItem(newsDetail: item,);
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
        desc: "Không có dữ liệu",
        onPressed: () => controller.onRefresh(),
      ),
    );



  }
}
