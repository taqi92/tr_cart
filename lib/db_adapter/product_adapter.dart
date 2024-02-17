import 'package:hive/hive.dart';

class Product {
  final int? id;
  final String? title;
  final String? content;
  final String? image;
  final String? thumbnail;
  final int? userId;

  Product(this.id, this.title, this.content, this.image, this.thumbnail,
      this.userId);
}

class ProductAdapter extends TypeAdapter<Product> {
  @override
  final typeId = 0;

  @override
  Product read(BinaryReader reader) {
    return Product(
      reader.read(),
      reader.read(),
      reader.read(),
      reader.read(),
      reader.read(),
      reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, Product obj) {
    writer.write(obj.id);
    writer.write(obj.title);
    writer.write(obj.content);
    writer.write(obj.image);
    writer.write(obj.thumbnail);
    writer.write(obj.userId);
  }
}
