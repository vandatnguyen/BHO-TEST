import 'package:finews_module/cores/services/news_api_service.dart'; 
import 'package:finews_module/pages/news_detail/html_parser/html_parser.dart';
import 'package:get/get.dart';

import 'news_detail_controller.dart'; 

class NewsDetailBinding extends Bindings {
  @override
  void dependencies() { 
    Get.lazyPut(() => NewsDetailController());
    Get.put<HtmlParser>( HtmlParser());
    Get.put<NewsService>(NewsServiceImpl());
  }
}
