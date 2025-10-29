class Category {
  final int id;
  final String name;
  final String? slug;
  final String? logoUrl;

  Category({
    required this.id,
    required this.name,
    this.slug,
    this.logoUrl,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json['id'],
        name: json['name'],
        slug: json['slug'],
        logoUrl: json['logo_url'],
      );
}

class SubCategory {
  final int id;
  final String name;
  final String slug;

  SubCategory({
    required this.id,
    required this.name,
    required this.slug,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
    );
  }
}

class Product {
  final int id;
  final String name;
  final String slug;
  final double price;

  Product({
    required this.id,
    required this.name,
    required this.slug,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      price: (json['price'] as num).toDouble(),
    );
  }
}
