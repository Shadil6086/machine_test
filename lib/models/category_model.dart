import '../core/api_constants.dart';

class CategoryModel {
  final String name;
  final String image;

  CategoryModel({required this.name, required this.image});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    final imagePath = json['category']['image'];

    return CategoryModel(
      name: json['category']['name'],
      image: imagePath == null || imagePath.isEmpty
          ? ""
          : "${ApiConstants.imageBaseUrl}/$imagePath",
    );
  }
}
