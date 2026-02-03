import 'package:flutter/material.dart';
import '../models/category_model.dart';
import '../core/app_colors.dart';

class CategoryRow extends StatelessWidget {
  final List<CategoryModel> categories;
  const CategoryRow({required this.categories});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (_, i) => Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: AppColors.primary.withOpacity(.1),
                child: Image.network(
                  categories[i].image,
                  height: 30,
                  errorBuilder: (_, __, ___) =>
                  const Icon(Icons.category),
                ),
              ),
              SizedBox(height: 6),
              Text(categories[i].name, style: TextStyle(fontSize: 12))
            ],
          ),
        ),
      ),
    );
  }
}
