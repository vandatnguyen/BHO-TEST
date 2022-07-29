import 'package:finews_module/pages/home/home_page.dart';
import 'package:finews_module/pages/home/home_page_bindding.dart';
import 'package:get/get.dart';
import 'package:finews_module/routes/app_routes.dart';

import 'app_routes.dart';

// ignore: avoid_classes_with_only_static_members
class AppPages {
  static const INITIAL = AppRoutes.homeParent;

  static final tradingRoutes = [
    GetPage(
      name: AppRoutes.homeParent,
      page: () =>  HomePageView(),
      binding: HomePageBinding(),
    )
  ];
}
