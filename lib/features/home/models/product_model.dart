class Product {
  final String brand;
  final String name;
  final String imageUrl;
  final double price;
  final String category;
  final String description;
  Product({
    required this.brand,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.category,
    required this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      brand: json['brand'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      price: (json['price'] as num).toDouble(),
      category: json['category'],
      description: json['description'],
    );
  }
}
