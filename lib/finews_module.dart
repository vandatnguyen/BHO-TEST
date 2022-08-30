import 'package:finews_module/routes/app_pages.dart';
import 'package:finews_module/shared_widgets/news_box/news_box_controller.dart';
import 'package:get/get.dart';

import 'cores/services/news_api_service.dart';
import 'pages/home/main_provider.dart';
import 'pages/news_detail/html_parser/html_parser.dart';
import 'routes/app_routes.dart';

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
  }

  static void openFiNewsApp() {
    Get.toNamed(AppRoutes.homeParent);
  }
}

