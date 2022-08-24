import 'package:finews_module/cores/models/news_detail.dart';
import 'package:finews_module/cores/services/news_api_service.dart';
import 'package:finews_module/cores/states/base_controller.dart';
import 'package:finews_module/data/entities/article_list_response.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_notifier.dart';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
class HomePageController extends BaseController
    with
        StateMixin<List<ArticleWrapper>> {

  RefreshController refreshController = RefreshController();
  List<ArticleWrapper> listArticle = <ArticleWrapper>[];
  @override
  void onInit() {
    print("jgjhjhjhjhj onInit");
    super.onInit();
    getArticleV2();
    getArticleHots();
    getArticleHotsV2();
  }

  Future onRefresh() async {
    await getArticleV2();
    await getArticleHots();
    await getArticleHotsV2();
    refreshController.refreshCompleted();
  }

  Future getArticleV2() async {
    var listArticle = await Get.find<NewsService>().getArticleV2(topic: "31");
    print("jgjhjhjhjhj ${listArticle.articles.length}");
    for (var value in listArticle.articles) {
      var wrapper = ArticleWrapper();
      wrapper.model = value;
      this.listArticle.add(wrapper);
    }
    change(this.listArticle, status: RxStatus.success());
  }

  Future getArticleHots() async {
    var listArticle = await Get.find<NewsService>().getArticleHots(topic: "31");
    // print("jgjhjhjhjhj ${listArticle.articles.length}");
    // for (var value in listArticle.articles) {
    //   print("jgjhjhjhjhj ${value.title}");
    // };
    // this.listArticle = listArticle.articles;
    if (listArticle.articles != null && listArticle.articles.length > 0){
      var wrapper = ArticleWrapper();
      wrapper.type = 1;
      wrapper.model = listArticle.articles[0];
      this.listArticle.insert(0, wrapper);
      change(this.listArticle, status: RxStatus.success());
    }
  }

  Future getArticleHotsV2() async {
    var listArticle = await Get.find<NewsService>().getArticleHotsV2(topic: "31");
    // print("jgjhjhjhjhj ${listArticle.articles.length}");
    // for (var value in listArticle.articles) {
    //   print("jgjhjhjhjhj ${value.title}");
    // };
    // this.listArticle = listArticle.articles;
    var wrapper = ArticleWrapper();
    wrapper.type = 2;
    wrapper.listNewsDetailModel = listArticle.articles;
    for (var value in this.listArticle) {
      if (value.type == 2){
        this.listArticle.remove(value);
        this.listArticle.insert(3, wrapper);
        change(this.listArticle, status: RxStatus.success());
        return;
      }
    }
    this.listArticle.insert(3, wrapper);
    change(this.listArticle, status: RxStatus.success());
  }
}

class ArticleWrapper{
  int type = 0;
  late List<NewsDetailModel> listNewsDetailModel;
  late NewsDetailModel model;
}