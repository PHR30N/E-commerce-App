class ProductResponse {
  final List<Product> items;
  final int page;
  final int pageSize;
  final int totalCount;
  final bool hasNextPage;
  final bool hasPreviousPage;

  ProductResponse({
    required this.items,
    required this.page,
    required this.pageSize,
    required this.totalCount,
    required this.hasNextPage,
    required this.hasPreviousPage,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      items: json['items'] != null
          ? List<Product>.from(
              json['items'].map((item) => Product.fromJson(item)),
            )
          : [],
      page: json['page'] as int? ?? 1,
      pageSize: json['pageSize'] as int? ?? 0,
      totalCount: json['totalCount'] as int? ?? 0,
      hasNextPage: json['hasNextPage'] as bool? ?? false,
      hasPreviousPage: json['hasPreviousPage'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((item) => item.toJson()).toList(),
      'page': page,
      'pageSize': pageSize,
      'totalCount': totalCount,
      'hasNextPage': hasNextPage,
      'hasPreviousPage': hasPreviousPage,
    };
  }
}

class Product {
  final String id;
  final String productCode;
  final String name;
  final String description;
  final String arabicName;
  final String arabicDescription;
  final String coverPictureUrl;
  final List<String>? productPictures;
  final double price;
  final int stock;
  final double weight;
  final String color;
  final double rating;
  final int reviewsCount;
  final int discountPercentage;
  final String sellerId;
  final List<String> categories;

  Product({
    required this.id,
    required this.productCode,
    required this.name,
    required this.description,
    required this.arabicName,
    required this.arabicDescription,
    required this.coverPictureUrl,
    this.productPictures,
    required this.price,
    required this.stock,
    required this.weight,
    required this.color,
    required this.rating,
    required this.reviewsCount,
    required this.discountPercentage,
    required this.sellerId,
    required this.categories,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String? ?? '',
      productCode: json['productCode'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      arabicName: json['arabicName'] as String? ?? '',
      arabicDescription: json['arabicDescription'] as String? ?? '',
      coverPictureUrl: json['coverPictureUrl'] as String? ?? '',
      productPictures: json['productPictures'] != null
          ? List<String>.from(json['productPictures'])
          : null,
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      stock: json['stock'] as int? ?? 0,
      weight: (json['weight'] as num?)?.toDouble() ?? 0.0,
      color: json['color'] as String? ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewsCount: json['reviewsCount'] as int? ?? 0,
      discountPercentage: json['discountPercentage'] as int? ?? 0,
      sellerId: json['sellerId'] as String? ?? '',
      categories: json['categories'] != null
          ? List<String>.from(json['categories'])
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productCode': productCode,
      'name': name,
      'description': description,
      'arabicName': arabicName,
      'arabicDescription': arabicDescription,
      'coverPictureUrl': coverPictureUrl,
      'productPictures': productPictures,
      'price': price,
      'stock': stock,
      'weight': weight,
      'color': color,
      'rating': rating,
      'reviewsCount': reviewsCount,
      'discountPercentage': discountPercentage,
      'sellerId': sellerId,
      'categories': categories,
    };
  }
}