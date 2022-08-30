import 'package:finews_module/routes/app_pages.dart';
import 'package:finews_module/shared_widgets/news_box/news_box_controller.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart';

import 'cores/services/news_api_service.dart';
import 'pages/home/main_provider.dart';
import 'pages/news_detail/html_parser/html_parser.dart';
import 'routes/app_routes.dart';
import 'package:timeago/timeago.dart' as timeago;

class FiNewsModule {
  static Future openNewsModule() async {
    initNewsRouteAndBinding();
    openFiNewsApp();
  }

  static void initNewsRouteAndBinding() {
    for (final value in AppPages.tradingRoutes) {
      if (!Get.routeTree.routes.contains(value)) {
        Get.addPage(value);
      }
    }
    Get.put<MainFiNewsProvider>(MainFiNewsProvider());
    Get.put<HtmlParser>(HtmlParser());
    Get.put<NewsService>(NewsServiceImpl());
    Get.put<NewsBoxController>(NewsBoxController());

    timeago.setLocaleMessages('en', MyCustomMessages());
  }


  static void openFiNewsApp() {
    Get.toNamed(AppRoutes.homeParent);
  }
}


// my_custom_messages.dart
class MyCustomMessages implements LookupMessages {
  @override String prefixAgo() => '';
  @override String prefixFromNow() => '';
  @override String suffixAgo() => '';
  @override String suffixFromNow() => '';
  @override String lessThanOneMinute(int seconds) => 'now';
  @override String aboutAMinute(int minutes) => '${minutes} phút trước';
  @override String minutes(int minutes) => '${minutes} phút trước';
  @override String aboutAnHour(int minutes) => '${minutes} phút trước';
  @override String hours(int hours) => '${hours} giờ trước';
  @override String aDay(int hours) => '${hours} giờ trước';
  @override String days(int days) => '${days} ngày trước';
  @override String aboutAMonth(int days) => '${days}d';
  @override String months(int months) => '${months}mo';
  @override String aboutAYear(int year) => '${year}y';
  @override String years(int years) => '${years}y';
  @override String wordSeparator() => ' ';
}