class ProductModel {
  final List<Product> products;
  final bool status;

  ProductModel({
    required this.products,
    required this.status,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    // Support both "products" and "best_seller_products"
    final productList = json['products'] ?? json['best_seller_products'];

    return ProductModel(
      products: (productList as List<dynamic>?)
              ?.map((v) => Product.fromJson(v))
              .toList() ??
          [],
      status: json['status'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'products': products.map((v) => v.toJson()).toList(),
      'status': status,
    };
  }

  /// 🔥 Only products with rating >= 4
  List<Product> get topRated =>
      products.where((p) => p.rating >= 4.0).toList();

  /// 🔥 Products marked as best seller
  List<Product> get bestSellers =>
      products.where((p) => p.bestSeller == 1).toList();
}

class Product {
  final int bestSeller;
  final Category? category;
  final String description;
  final int id;
  final String imagePath;
  final bool isFavorite;
  final String name;
  final double price;
  final double rating;

  Product({
    required this.bestSeller,
    this.category,
    required this.description,
    required this.id,
    required this.imagePath,
    required this.isFavorite,
    required this.name,
    required this.price,
    required this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      bestSeller: json['best_seller'] ?? 0,
      category: json['category'] != null
          ? Category.fromJson(json['category'])
          : null,
      description: json['description'] ?? '',
      id: json['id'] ?? 0,
      imagePath: json['image_path'] ?? '',
      isFavorite: json['is_favorite'] ?? false,
      name: json['name'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'best_seller': bestSeller,
      'category': category?.toJson(),
      'description': description,
      'id': id,
      'image_path': imagePath,
      'is_favorite': isFavorite,
      'name': name,
      'price': price,
      'rating': rating,
    };
  }
}

class Category {
  final String description;
  final int id;
  final String imagePath;
  final String title;

  Category({
    required this.description,
    required this.id,
    required this.imagePath,
    required this.title,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      description: json['description'] ?? '',
      id: json['id'] ?? 0,
      imagePath: json['image_path'] ?? '',
      title: json['title'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'id': id,
      'image_path': imagePath,
      'title': title,
    };
  }
}
