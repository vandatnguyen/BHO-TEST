 import '../../configs/constants.dart';
import '../models/news_detail.dart';
import '../networking/decoder.dart';
import 'api_services.dart';

abstract class NewsService extends ApiServices{
  NewsService(): super();
   Future<NewsDetailModel> getArticleInfo({required String id});
 
}

class NewsServiceImpl extends NewsService{
  NewsServiceImpl() : super();
 
  @override
  Future<NewsDetailModel> getArticleInfo({required String id }) async {
    return BaseDecoder(
      await api.getData(
        params: { 
          "articleId": id,
          "db24h":  "OBUG63LPORSWC3J2"
        },
        endPoint:  "/v1.0/articles/info",
        timeOut: AppConstants.TIME_OUT,
      ),
      decoder: NewsDetailModel.fromJson,
    ).decoded();
  }
 
}
