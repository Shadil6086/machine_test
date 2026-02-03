import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../core/app_colors.dart';
import '../screens/product_detail_screen.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  const ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => ProductDetailScreen(product: product)),
      ),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Expanded(
                child: Image.network(
                  product.image,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) =>
                  const Icon(Icons.image_not_supported),
                )
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Text(product.name,
                      maxLines: 2,
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  Text("QAR ${product.price}",
                      style: TextStyle(color: AppColors.primary)),
                  SizedBox(height: 6),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary),
                    onPressed: () {},
                    child: Text("Add"),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
