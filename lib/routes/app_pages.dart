import 'package:finews_module/pages/home/home_page.dart';
import 'package:finews_module/pages/home/home_page_bindding.dart';
import 'package:finews_module/pages/news_detail/news_detail.dart';
import 'package:finews_module/pages/news_detail/news_detail_binding.dart';
import 'package:finews_module/pages/webview/webview_binding.dart';
import 'package:finews_module/pages/webview/webview_scene.dart';
import 'package:finews_module/routes/app_routes.dart';
import 'package:get/get.dart';

import 'app_routes.dart';

class AppPages {

  static final newsRoutes = [
    GetPage(
      name: AppRoutes.homeParent2,
      page: () => const HomePageView(),
      binding: HomePageBinding(),
    ),
    GetPage(
      name: AppRoutes.newsDetail,
      page: () => const NewsDetailPageView(),
      binding: NewsDetailBinding(),
    ),
    GetPage(
      name: AppRoutes.newsWebview,
      page: () => const WebViewScene(),
      binding: WebviewBinding(),
    )
  ];
}
