import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../models/product_model.dart';
import '../widgets/product_card.dart';

class ProductListScreen extends StatelessWidget {
  final String title;
  final List<ProductModel> products;

  const ProductListScreen({
    super.key,
    required this.title,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(title),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: products.length,
        itemBuilder: (_, i) {
          return ProductCard(product: products[i]);
        },
      ),
    );
  }
}
