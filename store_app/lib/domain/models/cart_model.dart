class CartModel {
  final String cartId;
  final List<CartItemModel> cartItems;

  CartModel({
    required this.cartId,
    required this.cartItems,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    final rawItems = json['cartItems'] ??
        json['CartItems'] ??
        json['items'] ??
        json['Items'] ??
        [];

    List<CartItemModel> itemsList = [];
    if (rawItems is List) {
      itemsList = rawItems
          .map((e) => CartItemModel.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList();
    }

    return CartModel(
      cartId: json['cartId']?.toString() ??
          json['CartId']?.toString() ??
          json['id']?.toString() ??
          '',
      cartItems: itemsList,
    );
  }
}

class CartItemModel {
  final String itemId;
  final String productId;
  final String productName;
  final String productCoverUrl;
  final int productStock;
  final int weightInGrams;
  final int quantity;
  final num discountPercentage;
  final num basePricePerUnit;
  final num finalPricePerUnit;
  final num totalPrice;

  CartItemModel({
    required this.itemId,
    required this.productId,
    required this.productName,
    required this.productCoverUrl,
    required this.productStock,
    required this.weightInGrams,
    required this.quantity,
    required this.discountPercentage,
    required this.basePricePerUnit,
    required this.finalPricePerUnit,
    required this.totalPrice,
  });

  static int _toInt(dynamic val, [int defaultValue = 0]) {
    if (val == null) return defaultValue;
    if (val is num) return val.toInt();
    if (val is String) return int.tryParse(val) ?? (double.tryParse(val)?.toInt() ?? defaultValue);
    return defaultValue;
  }

  static num _toNum(dynamic val, [num defaultValue = 0]) {
    if (val == null) return defaultValue;
    if (val is num) return val;
    if (val is String) return num.tryParse(val) ?? defaultValue;
    return defaultValue;
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      itemId: json['itemId']?.toString() ?? json['ItemId']?.toString() ?? json['id']?.toString() ?? '',
      productId: json['productId']?.toString() ?? json['ProductId']?.toString() ?? '',
      productName: json['productName'] ?? json['ProductName'] ?? json['name'] ?? json['Name'] ?? 'Product',
      productCoverUrl:
          json['productCoverUrl'] ?? json['ProductCoverUrl'] ?? json['coverPictureUrl'] ?? '',
      productStock: _toInt(json['productStock'] ?? json['ProductStock']),
      weightInGrams: _toInt(json['weightInGrams'] ?? json['WeightInGrams']),
      quantity: _toInt(json['quantity'] ?? json['Quantity'], 1),
      discountPercentage: _toNum(json['discountPercentage'] ?? json['DiscountPercentage']),
      basePricePerUnit: _toNum(json['basePricePerUnit'] ?? json['BasePricePerUnit']),
      finalPricePerUnit: _toNum(json['finalPricePerUnit'] ?? json['FinalPricePerUnit']),
      totalPrice: _toNum(json['totalPrice'] ?? json['TotalPrice']),
    );
  }
}