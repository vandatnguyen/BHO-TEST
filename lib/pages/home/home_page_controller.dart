import 'package:finews_module/cores/models/news_detail.dart';
import 'package:finews_module/cores/services/news_api_service.dart';
import 'package:finews_module/cores/states/base_controller.dart';
import 'package:finews_module/data/entities/website.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePageController extends BaseController
    with StateMixin<List<ArticleWrapper>> {
  RefreshController refreshController = RefreshController();
  List<ArticleWrapper> listArticle = <ArticleWrapper>[];
  List<Website> listWebsite = <Website>[];

  @override
  void onInit() {
    super.onInit();
    getWebsite();
  }

  Future onRefresh() async {
    getWebsite();
    refreshController.refreshCompleted();
  }

  Future getWebsite() async {
    var response = await Get.find<NewsService>().getWebsite();
    listWebsite = response.websites;
    await getArticleV2();
    await getArticleHots();
    await getArticleHotsV2();
  }

  String? getTopicName(int id) {
    for (var value in listWebsite) {
      for (var t in value.topic) {
        if (t.id == id) {
          return t.name;
        }
      }
    }
    return null;
  }

  String? getSourceName(int id) {
    for (var t in listWebsite) {
      if (t.id == id) {
        return t.name;
      }
    }
    return null;
  }

  Future getArticleV2() async {
    var listArticle =
        await Get.find<NewsService>().getArticleV2(topic: 31.toString());
    for (var value in listArticle.articles) {
      var wrapper = ArticleWrapper();
      value.topicName = getTopicName(value.topic);
      value.sourceName = getSourceName(value.source);
      wrapper.model = value;
      this.listArticle.add(wrapper);
    }
    change(this.listArticle, status: RxStatus.success());
  }

  Future getArticleHots() async {
    var listArticle = await Get.find<NewsService>().getArticleHots(topic: "31");
    if (this.listArticle.isNotEmpty) {
      if (this.listArticle[0].type == 1) {
        this.listArticle.removeAt(0);
      }
    }
    var wrapper = ArticleWrapper();
    wrapper.type = 1;
    var detail = listArticle.articles[0];
    detail.sourceName = getSourceName(detail.source);
    detail.topicName = getTopicName(detail.topic);
    wrapper.model = detail;
    this.listArticle.insert(0, wrapper);
    change(this.listArticle, status: RxStatus.success());
  }

  Future getArticleHotsV2() async {
    var listArticle =
        await Get.find<NewsService>().getArticleHotsV2(topic: "31");

    if (this.listArticle.length > 2) {
      var wrapper = ArticleWrapper();
      wrapper.type = 2;
      wrapper.listNewsDetailModel = listArticle.articles;
      for (var value in this.listArticle) {
        if (value.type == 2) {
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
}

class ArticleWrapper {
  int type = 0;
  late List<NewsDetailModel> listNewsDetailModel;
  late NewsDetailModel model;
}
