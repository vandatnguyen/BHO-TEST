import 'package:finews_module/data/entities/article_list_response.dart';
import 'package:finews_module/data/entities/website_response.dart';

import '../../configs/constants.dart';
import '../../data/entities/comment_list_article.dart';
import '../../data/entities/comment_response.dart';
import '../../data/entities/like_comment_response.dart';
import '../models/news_detail.dart';
import '../networking/decoder.dart';
import 'api_services.dart';

abstract class NewsService extends ApiServices {
  NewsService() : super();

  Future<NewsDetailModel> getArticleInfo({required String id});

  Future<WebsiteResponse> getWebsite();

  Future<ArticleListResponse> getArticleV2(
      {required String topic, required double last});

  Future<ArticleListResponse> getArticleHots({required String topic});

  Future<ArticleListResponse> getArticleHotsV2({required String topic});

  Future<ArticleListResponse> getArticleRelative({required String id});

  Future<ArticleListResponse> getArticleWithTag(String tag, {double last});

  Future<ArticleListResponse> getArticleWithTopic(String articleId,
      {double last});

  Future<ArticleListResponse> getArticleStock(String stock, {double last});

  Future<CommentListResponse> getAllComment(String articleId);

  Future<CommentListResponse> getReplyComment(String commentParentId);

  Future<CommentResponse> comment(String articleId, String content);

  Future<CommentResponse> replyComment(String commentId, String content);

  Future<LikeCommentResponse> likeComment(String commentId);
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
            decoder: ArticleListResponse.fromJson)
        .decoded();
  }

  @override
  Future<ArticleListResponse> getArticleWithTag(
    String tag, {
    double last = -1,
  }) async {
    return BaseDecoder(
            await api.getData(
              params: {
                "tag": tag,
                "db24h": "OBUG63LPORSWC3J2",
                "last": last > 0 ? last.toInt().toString() : ""
              },
              endPoint: "/v1.0/articles/tag",
              timeOut: AppConstants.TIME_OUT,
            ),
            decoder: ArticleListResponse.fromJson)
        .decoded();
  }

  @override
  Future<ArticleListResponse> getArticleWithTopic(
    String articleId, {
    double last = -1,
  }) async {
    return BaseDecoder(
            await api.getData(
              params: {
                "articleId": articleId,
                "db24h": "OBUG63LPORSWC3J2",
                "last": last > 0 ? last.toInt().toString() : ""
              },
              endPoint: "/v1.0/articles/topic",
              timeOut: AppConstants.TIME_OUT,
            ),
            decoder: ArticleListResponse.fromJson)
        .decoded();
  }

  @override
  Future<WebsiteResponse> getWebsite() async {
    return BaseDecoder(
      await api.getData(
        params: {"db24h": "OBUG63LPORSWC3J2"},
        endPoint: "/v1.0/website",
        timeOut: AppConstants.TIME_OUT,
      ),
      decoder: WebsiteResponse.fromJson,
    ).decoded();
  }

  @override
  Future<ArticleListResponse> getArticleV2(
      {required String topic, required double last}) async {
    var params = {
      "topic": topic,
      "source": "666666",
      "length": "20",
      "db24h": "OBUG63LPORSWC3J2"
    };
    if (last > 0) {
      params = {
        "topic": topic,
        "source": "666666",
        "length": "20",
        "db24h": "OBUG63LPORSWC3J2",
        "last": last.toInt().toString()
      };
    }
    return BaseDecoder(
      await api.getData(
        params: params,
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

  @override
  Future<ArticleListResponse> getArticleStock(
    String stock, {
    double last = -1,
  }) async {
    return BaseDecoder(
      await api.getData(
        params: {
          "stock": stock,
          "db24h": "OBUG63LPORSWC3J2",
          "last": last > 0 ? last.toInt().toString() : "",
        },
        endPoint: "/v1.0/articles/stock",
        timeOut: AppConstants.TIME_OUT,
      ),
      decoder: ArticleListResponse.fromJson,
    ).decoded();
  }

  @override
  Future<CommentListResponse> getAllComment(String articleId) async {
    return BaseDecoder(
      await api.getData(
        params: {
          "db24h": "OBUG63LPORSWC3J2",
        },
        endPoint: "/v1.0/article/$articleId/comment",
        timeOut: AppConstants.TIME_OUT,
      ),
      decoder: CommentListResponse.fromJson,
    ).decoded();
  }

  @override
  Future<CommentResponse> comment(String articleId, String content) async {
    print(content);
    return BaseDecoder(
      await api.postData(
        params: {
          "db24h": "OBUG63LPORSWC3J2",
          "user": {
            "phoneNumber": "03336688888",
            "username": "phamviettu",
            "avatarUrl":
                "http://graph.facebook.com/2978211225754795/picture?type=large",
            "email": "phamviettu@gmail.com"
          },
          "content": content
        },
        endPoint: "/v1.0/article/$articleId/comment",
        timeOut: AppConstants.TIME_OUT,
      ),
      decoder: CommentResponse.fromJson,
    ).decoded();
  }

  @override
  Future<CommentListResponse> getReplyComment(String commentParentId) async {
    return BaseDecoder(
      await api.getData(
    params: {
    "db24h": "OBUG63LPORSWC3J2",
    },
      endPoint: "/v1.0/comment/$commentParentId/reply",
      timeOut: AppConstants.TIME_OUT,
    ),
    decoder: CommentListResponse.fromJson,
    ).decoded();
  }

  @override
  Future<LikeCommentResponse> likeComment(String commentId) async {
    return BaseDecoder(
      await api.postData(
        params: {
          "db24h": "OBUG63LPORSWC3J2",
        },
        endPoint: "/v1.0/comment/$commentId/like",
        timeOut: AppConstants.TIME_OUT,
      ),
      decoder: LikeCommentResponse.fromJson,
    ).decoded();
  }

  @override
  Future<CommentResponse> replyComment(String commentId, String content) async {
    return BaseDecoder(
      await api.postData(
        params: {
          "db24h": "OBUG63LPORSWC3J2",
          "content": content,
          "user": {
            "phoneNumber": "03336688888",
            "username": "phamviettu",
            "avatarUrl": "http://graph.facebook.com/2978211225754795/picture?type=large",
            "email": "phamviettu@gmail.com"
          }
        },
        endPoint: "/v1.0/comment/$commentId/reply",
        timeOut: AppConstants.TIME_OUT,
      ),
      decoder: CommentResponse.fromJson,
    ).decoded();
  }
}
