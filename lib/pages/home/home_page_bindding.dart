import 'package:finews_module/cores/services/news_api_service.dart';
import 'package:finews_module/pages/home/home_page_controller.dart';
import 'package:finews_module/shared_widgets/news_box/news_box_controller.dart';
import 'package:get/get.dart';

class HomePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<NewsService>(NewsServiceImpl());
    Get.lazyPut(() => NewsBoxController());
  }
}
