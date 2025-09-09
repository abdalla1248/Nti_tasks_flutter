import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:restaurant/feature/home/data/model/product_model.dart';
import 'package:shimmer/shimmer.dart';

final List<Product> defaultProducts = [
  Product(
    id: 0,
    name: "Cheese Burger",
    bestSeller: 1,
    description: "Delicious cheese burger",
    price: 9.99,
    imagePath: "https://images.unsplash.com/photo-1600891964599-f61ba0e24092?fit=crop&w=400&h=250",
    rating: 4.5,
    isFavorite: false,
  ),
  Product(
    id: 1,
    name: "Pizza Margherita",
    bestSeller: 1,
    description: "Classic pizza margherita",
    price: 12.50,
    imagePath: "https://images.unsplash.com/photo-1594007654740-5b3e1d052988?fit=crop&w=400&h=250",
    rating: 4.8,
    isFavorite: false,
  ),
  Product(
    id: 2,
    name: "Pasta Carbonara",
    bestSeller: 1,
    description: "Creamy pasta carbonara",
    price: 11.20,
    imagePath: "https://images.unsplash.com/photo-1603133872877-c7c5e0f8f82f?fit=crop&w=400&h=250",
    rating: 4.3,
    isFavorite: false,
  ),
];


class BestSellerSection extends StatelessWidget {
  final List<Product>? products;
  final bool isLoading;

  const BestSellerSection({
    super.key,
    required this.products,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) return _buildLoadingShimmer();

    final productList = products ?? defaultProducts;

    return SizedBox(
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: productList.length,
        itemBuilder: (context, index) {
          final product = productList[index];
          return Container(
            width: 120,
            margin: const EdgeInsets.only(left: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12)),
                  child: CachedNetworkImage(
                    imageUrl: product.imagePath,
                    height: 80,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        Container(color: Colors.grey[300]),
                    errorWidget: (context, url, error) => Container(
                      height: 80,
                      color: Colors.grey[300],
                      child: const Icon(Icons.error, color: Colors.red),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  product.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '\$${product.price}',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildLoadingShimmer() {
    return SizedBox(
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 120,
              margin: const EdgeInsets.only(left: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        },
      ),
    );
  }
}
