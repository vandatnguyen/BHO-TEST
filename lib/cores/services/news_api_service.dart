import 'package:finews_module/cores/resources/data_state.dart';
import 'package:finews_module/data/entities/article_list_response.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../configs/constants.dart';
import '../models/news_detail.dart';
import '../networking/decoder.dart';
import 'api_services.dart';

abstract class NewsService extends ApiServices {
  NewsService() : super();

  Future<NewsDetailModel> getArticleInfo({required String id});

  Future<ArticleListResponse> getArticleV2({required String topic});
  Future<ArticleListResponse> getArticleHots({required String topic});
  Future<ArticleListResponse> getArticleHotsV2({required String topic});
  Future<ArticleListResponse> getArticleRelative({required String id});
}

class NewsServiceImpl extends NewsService {
  NewsServiceImpl() : super();

  @override
  Future<NewsDetailModel> getArticleInfo({required String id}) async {
    return BaseDecoder(
      await api.getData(
        params: {"articleId": id, "db24h": "OBUG63LPORSWC3J2"},
        endPoint: "/v1.0/articles/info",
        timeOut: AppConstants.TIME_OUT,
      ),
      decoder: NewsDetailModel.fromJson,
    ).decoded();
  }

  @override
  Future<ArticleListResponse> getArticleRelative({required String id}) async {
    return BaseDecoder(
      await api.getData(
        params: {"articleId": id, "db24h": "OBUG63LPORSWC3J2"},
        endPoint: "/v1.0/articles/relative",
        timeOut: AppConstants.TIME_OUT,
      ),
      decoder: ArticleListResponse.fromJson,
    ).decoded();
  }

  @override
  Future<ArticleListResponse> getArticleV2({required String topic}) async {
    return BaseDecoder(
      await api.getData(
        params: {
          "topic": "31",
          "source": "666666",
          "length": "20",
          "db24h": "OBUG63LPORSWC3J2"
        },
        endPoint: "/v1.0/articlev2",
        timeOut: AppConstants.TIME_OUT,
      ),
      decoder: ArticleListResponse.fromJson,
    ).decoded();
  }

  @override
  Future<ArticleListResponse> getArticleHots({required String topic}) async {
    return BaseDecoder(
      await api.getData(
        params: {"length": "20", "db24h": "OBUG63LPORSWC3J2"},
        endPoint: "/v1.0/articles/hots",
        timeOut: AppConstants.TIME_OUT,
      ),
      decoder: ArticleListResponse.fromJson,
    ).decoded();
  }

  @override
  Future<ArticleListResponse> getArticleHotsV2({required String topic}) async {
    return BaseDecoder(
      await api.getData(
        params: {"length": "20", "db24h": "OBUG63LPORSWC3J2"},
        endPoint: "/v1.0/articles/hotsv2",
        timeOut: AppConstants.TIME_OUT,
      ),
      decoder: ArticleListResponse.fromJson,
    ).decoded();
  }
}
