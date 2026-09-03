class Product {
  final String brand;
  final String name;
  final String imageUrl;
  final double price;

  Product({
    required this.brand,
    required this.name,
    required this.imageUrl,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      brand: json['brand'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      price: (json['price'] as num).toDouble(),
    );
  }
}
