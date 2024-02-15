/*class IssueResponse {
  final int? id;
  final String? title;
  final User? user;
  final String? createdAt;
  final List<Labels>? labels;
  final String? body;

  IssueResponse({
    this.id,
    this.title,
    this.user,
    this.labels,
    this.createdAt,
    this.body,
  });

  IssueResponse.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        title = json['title'] as String?,
        user = (json['user'] as Map<String, dynamic>?) != null
            ? User.fromJson(json['user'] as Map<String, dynamic>)
            : null,
        labels = (json['labels'] as List?)
            ?.map((dynamic e) => Labels.fromJson(e as Map<String, dynamic>))
            .toList(),
        createdAt = json['created_at'] as String?,
        body = json['body'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'user': user?.toJson(),
        'labels': labels?.map((e) => e.toJson()).toList(),
        'body': body,
      };

}

class User {
  final String? login;

  User({this.login});

  User.fromJson(Map<String, dynamic> json) : login = json['login'] as String?;

  Map<String, dynamic> toJson() => {'login': login};
}

class Labels {
  final int? id;
  final String? name;
  final String? color;
  final String? description;

  Labels({
    this.id,
    this.name,
    this.color,
    this.description,
  });

  Labels.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        color = json['color'] as String?,
        description = json['description'] as String?;

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'color': color, 'description': description};

}*/

class ProductResponse {
  final int? id;
  final String? slug;
  final String? url;
  final String? title;
  final String? content;
  final String? image;
  final String? thumbnail;
  final String? status;
  final String? category;
  final String? publishedAt;
  final String? updatedAt;
  final int? userId;

  ProductResponse({
    this.id,
    this.slug,
    this.url,
    this.title,
    this.content,
    this.image,
    this.thumbnail,
    this.status,
    this.category,
    this.publishedAt,
    this.updatedAt,
    this.userId,
  });

  ProductResponse.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        slug = json['slug'] as String?,
        url = json['url'] as String?,
        title = json['title'] as String?,
        content = json['content'] as String?,
        image = json['image'] as String?,
        thumbnail = json['thumbnail'] as String?,
        status = json['status'] as String?,
        category = json['category'] as String?,
        publishedAt = json['publishedAt'] as String?,
        updatedAt = json['updatedAt'] as String?,
        userId = json['userId'] as int?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'slug' : slug,
    'url' : url,
    'title' : title,
    'content' : content,
    'image' : image,
    'thumbnail' : thumbnail,
    'status' : status,
    'category' : category,
    'publishedAt' : publishedAt,
    'updatedAt' : updatedAt,
    'userId' : userId
  };
}


