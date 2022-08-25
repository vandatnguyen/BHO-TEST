import 'package:finews_module/routes/app_pages.dart';
import 'package:get/get.dart';
import 'cores/services/news_api_service.dart';
import 'pages/home/main_provider.dart';
import 'pages/news_detail/html_parser/html_parser.dart';
import 'routes/app_routes.dart';

class FiNewsModule {
  static Future openNewsModule() async {
    initGetxTrading();
    // Get.toNamed(AppRoutes.MAIN);
    openFiNewsApp();
  }

  static void initGetxTrading() {
    // if (Get.routeTree.routes.isNotEmpty) {
    for (final value in AppPages.tradingRoutes) {
      if (!Get.routeTree.routes.contains(value)) {
        Get.addPage(value);
      }
    }
    // }
    Get.put<MainFiNewsProvider>(MainFiNewsProvider());
    Get.put<HtmlParser>(HtmlParser());
    Get.put<NewsService>(NewsServiceImpl());
  }
}

void openFiNewsApp() {
  Get.toNamed(AppRoutes.homeParent);
}
