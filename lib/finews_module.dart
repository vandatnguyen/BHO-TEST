import 'package:finews_module/pages/forum/forum_scene_controller.dart';
import 'package:finews_module/pages/home/home_page_controller.dart';
import 'package:finews_module/pages/home/main_tikop_provider.dart';
import 'package:finews_module/pages/home/main_trading_provider.dart';
import 'package:finews_module/pages/news_detail/news_detail_controller.dart';
import 'package:finews_module/pages/webview/webview_scene_controller.dart';
import 'package:finews_module/routes/app_pages.dart';
import 'package:finews_module/shared_widgets/news_box/news_bds_box_controller.dart';
import 'package:finews_module/shared_widgets/news_box/news_box_controller.dart';
import 'package:finews_module/shared_widgets/news_box/news_stock_box_controller.dart';
import 'package:finews_module/shared_widgets/news_box/news_trading_box_controller.dart';
import 'package:finews_module/tracking/event_tracking.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:timeago/timeago.dart';

import 'configs/constants.dart';
import 'configs/service_api_config.dart';
import 'cores/services/news_api_service.dart';
import 'pages/home/main_provider.dart';
import 'pages/news_detail/html_parser/html_parser.dart';
import 'routes/app_routes.dart';
import 'package:timeago/timeago.dart' as timeago;

class FiNewsModule {
  // static Future openNewsModule() async {
  //   initNewsRouteAndBinding();
  //   openFiNewsApp();
  // }

  static EnvironmentConfiguration envFinews = EnvironmentConfiguration.staging;

  static void saveToken(String token) {
    var box = GetStorage();
    box.write("tikop_token", token);
  }

  static void saveUserInfo(String? phone, String? name, String? email, String? avatar) {
    var box = GetStorage();
    box.write("tikop_user_phone", phone);
    box.write("tikop_user_name", name);
    box.write("tikop_user_email", email);
    box.write("tikop_user_avatar", avatar);
  }

  static void openFinewsModule(
      {Function(String stockSymbol)? openStockDetail}) {
    if (!Get.isRegistered<MainFiNewsProvider>()) {
      Get.put<MainFiNewsTradingProvider>(
        MainFiNewsTradingProvider(
            openStockDetail
        ),
      );
    }
  }

  static void openFinewsModuleFromTikop(EnvironmentConfiguration envConfig,
      {Function(String stockSymbol)? openStockDetail}) {
    envFinews = envConfig;
    print("envFinews: " + envFinews.name);
    Environment().initConfig(envFinews);
    if (!Get.isRegistered<MainFiNewsProvider>()) {
      Get.put<MainFiNewsTikopProvider>(
        MainFiNewsTikopProvider(
            openStockDetail
        ),
      );
    }
  }

  static void initNewsRouteAndBinding() {
    EventManager().initEventTracking();
    Get.lazyPut(() => NewsHomePageController(), tag: "666666");
    Get.lazyPut(() => NewsHomePageController());
    for (final value in AppPages.newsRoutes) {
      if (!Get.routeTree.routes.contains(value)) {
        Get.addPage(value);
      }
    }
    Get.put<MainFiNewsProvider>(MainFiNewsProvider());
    Get.put<HtmlParser>(HtmlParser());
    Get.put<NewsService>(NewsServiceImpl());
    Get.put<NewsBoxController>(NewsBoxController());
    // Get.put<NewsDetailController>(NewsDetailController());
    Get.put<NewsStockBoxController>(NewsStockBoxController());
    Get.put<NewsTradingBoxController>(NewsTradingBoxController());
    Get.put<NewsBDSBoxController>(NewsBDSBoxController());
    Get.put<ForumController>(ForumController());
    timeago.setLocaleMessages('en', MyCustomMessages());
  }

// static void openFiNewsApp() {
//   Get.toNamed(AppRoutes.homeParent);
// }
}

// my_custom_messages.dart
class MyCustomMessages implements LookupMessages {
  @override
  String prefixAgo() => '';

  @override
  String prefixFromNow() => '';

  @override
  String suffixAgo() => '';

  @override
  String suffixFromNow() => '';

  @override
  String lessThanOneMinute(int seconds) => 'Vừa xong';

  @override
  String aboutAMinute(int minutes) => '${minutes} phút trước';

  @override
  String minutes(int minutes) => '${minutes} phút trước';

  @override
  String aboutAnHour(int minutes) => '1 giờ trước';

  @override
  String hours(int hours) => '${hours} giờ trước';

  @override
  String aDay(int hours) => '${(hours / 24).round()} ngày trước';

  @override
  String days(int days) => '${days} ngày trước';

  @override
  String aboutAMonth(int days) => '1 tháng trước';

  @override
  String months(int months) => '${months} tháng trước';

  @override
  String aboutAYear(int year) => '1 năm trước';

  @override
  String years(int years) => '${years} năm trước';

  @override
  String wordSeparator() => ' ';
}
