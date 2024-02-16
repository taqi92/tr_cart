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
  int quantity;
  bool isVisible;

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
    required this.isVisible,
    required this.quantity,
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
        quantity = 1,
        isVisible = true,
        userId = json['userId'] as int?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'slug': slug,
        'url': url,
        'title': title,
        'content': content,
        'image': image,
        'thumbnail': thumbnail,
        'status': status,
        'category': category,
        'publishedAt': publishedAt,
        'updatedAt': updatedAt,
        'userId': userId
      };
}
