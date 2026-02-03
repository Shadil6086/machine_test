import 'package:flutter/material.dart';
import '../core/api_constants.dart';
import '../core/api_services.dart';
import '../core/app_colors.dart';
import '../core/storage_services.dart';

import '../models/banner_model.dart';
import '../models/category_model.dart';
import '../models/product_model.dart';

import '../widgets/banner_slider.dart';
import '../widgets/category_row.dart';
import '../widgets/product_card.dart';

import 'product_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool loading = true;

  List<BannerModel> banners = [];
  List<CategoryModel> categories = [];

  List<ProductModel> featured = [];
  List<ProductModel> dailyBest = [];
  List<ProductModel> recentlyAdded = [];
  List<ProductModel> popular = [];
  List<ProductModel> trending = [];

  Future<void> fetchHomeData() async {
    try {
      final user = await StorageService.getUser();

      final response = await ApiService.post(
        "${ApiConstants.home}?id=${user['id']}&token=${user['token']}",
        {},
      );

      banners = (response['banner1'] as List)
          .map((e) => BannerModel.fromJson(e))
          .toList();

      categories = (response['categories'] as List)
          .map((e) => CategoryModel.fromJson(e))
          .toList();

      featured = (response['featured_products'] ??
          response['newarrivals'] ??
          [])
          .map<ProductModel>((e) => ProductModel.fromJson(e))
          .toList();

      dailyBest = (response['daily_best_selling'] ??
          response['best_seller'] ??
          [])
          .map<ProductModel>((e) => ProductModel.fromJson(e))
          .toList();

      recentlyAdded = (response['recently_added'] ??
          response['newarrivals'] ??
          [])
          .map<ProductModel>((e) => ProductModel.fromJson(e))
          .toList();

      popular = (response['popular_products'] ??
          response['best_seller'] ??
          [])
          .map<ProductModel>((e) => ProductModel.fromJson(e))
          .toList();

      trending = (response['trending_products'] ??
          response['newarrivals'] ??
          [])
          .map<ProductModel>((e) => ProductModel.fromJson(e))
          .toList();
    } catch (e) {
      debugPrint("Home API error: $e");
    }

    setState(() => loading = false);
  }

  @override
  void initState() {
    super.initState();
    fetchHomeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text("Sungod Home"),
        actions: const [
          Icon(Icons.search),
          SizedBox(width: 12),
          Icon(Icons.shopping_cart_outlined),
          SizedBox(width: 12),
        ],
      ),

      body: loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
        onRefresh: fetchHomeData,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              BannerSlider(banners: banners),

              sectionTitle("Categories"),
              CategoryRow(categories: categories),

              buildSection(
                title: "Featured Products",
                products: featured,
              ),

              buildSection(
                title: "Daily Best Selling",
                products: dailyBest,
              ),

              Padding(
                padding: const EdgeInsets.all(12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    banners.isNotEmpty ? banners.last.image : "",
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              buildSection(
                title: "Recently Added",
                products: recentlyAdded,
              ),

              buildSection(
                title: "Popular Products",
                products: popular,
              ),

              buildSection(
                title: "Trending Products",
                products: trending,
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),

      ///  BOTTOM NAV
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: "Categories"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 16, 12, 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildSection({
    required String title,
    required List<ProductModel> products,
  }) {
    if (products.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionHeader(
          title: title,
          onViewAll: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    ProductListScreen(title: title, products: products),
              ),
            );
          },
        ),
        productGrid(products),
      ],
    );
  }

  Widget sectionHeader({
    required String title,
    required VoidCallback onViewAll,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 16, 12, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style:
              const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          GestureDetector(
            onTap: onViewAll,
            child: Text(
              "View all",
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget productGrid(List<ProductModel> products) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (_, index) {
        return ProductCard(product: products[index]);
      },
    );
  }
}
