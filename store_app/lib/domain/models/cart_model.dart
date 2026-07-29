class CartModel {
  final String cartId;
  final List<CartItemModel> cartItems;

  CartModel({
    required this.cartId,
    required this.cartItems,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      cartId: json['cartId'] ?? json['CartId'] ?? '',
      cartItems: (json['cartItems'] ?? json['CartItems'] as List<dynamic>?)
              ?.map((e) => CartItemModel.fromJson(Map<String, dynamic>.from(e)))
              .toList() ??
          [],
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

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      itemId: json['itemId'] ?? json['ItemId'] ?? '',
      productId: json['productId'] ?? json['ProductId'] ?? '',
      productName: json['productName'] ?? json['ProductName'] ?? 'Product',
      productCoverUrl:
          json['productCoverUrl'] ?? json['ProductCoverUrl'] ?? '',
      productStock: json['productStock'] ?? json['ProductStock'] ?? 0,
      weightInGrams: json['weightInGrams'] ?? json['WeightInGrams'] ?? 0,
      quantity: json['quantity'] ?? json['Quantity'] ?? 1,
      discountPercentage:
          json['discountPercentage'] ?? json['DiscountPercentage'] ?? 0,
      basePricePerUnit:
          json['basePricePerUnit'] ?? json['BasePricePerUnit'] ?? 0,
      finalPricePerUnit:
          json['finalPricePerUnit'] ?? json['FinalPricePerUnit'] ?? 0,
      totalPrice: json['totalPrice'] ?? json['TotalPrice'] ?? 0,
    );
  }
}