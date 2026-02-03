import '../core/api_constants.dart';

class BannerModel {
  final String image;
  final String title;

  BannerModel({required this.image, required this.title});

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      image: json['image'] == null || json['image'].isEmpty
          ? ""
          : "${ApiConstants.imageBaseUrl}/${json['image']}",
      title: json['title'] ?? '',
    );
  }
}
