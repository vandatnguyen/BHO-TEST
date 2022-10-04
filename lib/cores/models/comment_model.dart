class CommentModel {
  String? userName;
  String? email;
  String? content;
  int? id;
  String? parentId;
  String? articleId;
  int? type;
  int? numberLike;
  int? numberComment;
  int? createdDate;

  CommentModel({
    this.userName,
    this.email,
    this.content,
    this.id,
    this.parentId,
    this.articleId,
    this.type,
    this.numberLike,
    this.numberComment,
    this.createdDate,
  });

  CommentModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    email = json['email'];
    content = json['content'];
    id = json['id'];
    parentId = json['parentId'];
    articleId = json['articleId'];
    type = json['type'];
    numberLike = json['numberLike'];
    numberComment = json['numberComment'];
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['content'] = this.content;
    data['id'] = this.id;
    data['parentId'] = this.parentId;
    data['articleId'] = this.articleId;
    data['type'] = this.type;
    data['numberLike'] = this.numberLike;
    data['numberComment'] = this.numberComment;
    data['createdDate'] = this.createdDate;
    return data;
  }
}
