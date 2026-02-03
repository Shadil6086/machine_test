import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../models/banner_model.dart';

class BannerSlider extends StatelessWidget {
  final List<BannerModel> banners;

  const BannerSlider({super.key, required this.banners});

  @override
  Widget build(BuildContext context) {
    if (banners.isEmpty) {
      return const SizedBox.shrink();
    }

    return CarouselSlider(
      options: CarouselOptions(
        height: 180,
        autoPlay: true,
        viewportFraction: 1,
        enlargeCenterPage: false,
      ),
      items: banners.map((banner) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            banner.image,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              color: Colors.grey[300],
              child: const Icon(Icons.image_not_supported),
            ),
          ),
        );
      }).toList(),
    );
  }
}
