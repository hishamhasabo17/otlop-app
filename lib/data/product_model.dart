class ProductModel {
  final int id;
  final String name;
  final String description;
  final String pictureUrl;
  final double price;
  final int brandId;
  final String brand;
  final int categoryId;
  final String category;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureUrl,
    required this.price,
    required this.brandId,
    required this.brand,
    required this.categoryId,
    required this.category,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      pictureUrl: json['pictureUrl'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      brandId: json['brandId'] ?? 0,
      brand: json['brand'] ?? '',
      categoryId: json['categoryId'] ?? 0,
      category: json['category'] ?? '',
    );
  }
}