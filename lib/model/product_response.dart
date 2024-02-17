class ProductResponse {
  final int? id;
  final String? title;
  final String? content;
  final String? image;
  final String? thumbnail;
  final String? status;
  final int? userId;
  int quantity;
  bool isVisible;

  ProductResponse({
    this.id,
    this.title,
    this.content,
    this.image,
    this.thumbnail,
    this.status,
    this.userId,
    required this.isVisible,
    required this.quantity,
  });

  ProductResponse.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        title = json['title'] as String?,
        content = json['content'] as String?,
        image = json['image'] as String?,
        thumbnail = json['thumbnail'] as String?,
        status = json['status'] as String?,

        quantity = 1,
        isVisible = true,
        userId = json['userId'] as int?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'content': content,
        'image': image,
        'thumbnail': thumbnail,
        'status': status,
        'userId': userId
      };
}
