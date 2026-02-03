import '../core/api_constants.dart';

class ProductModel {
  final String name;
  final String price;
  final String image;

  ProductModel({
    required this.name,
    required this.price,
    required this.image,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final img = json['image'];

    return ProductModel(
      name: json['name'] ?? '',
      price: json['price'] ?? '',
      image: img == null || img.isEmpty
          ? ""
          : "${ApiConstants.imageBaseUrl}/$img",
    );
  }
}
