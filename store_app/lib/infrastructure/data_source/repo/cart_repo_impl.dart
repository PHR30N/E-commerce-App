import 'package:e_commerce_app/core/network/errors/failures.dart';
import 'package:e_commerce_app/infrastructure/data_source/abstraction/cart_data_source.dart';
import 'package:e_commerce_app/infrastructure/data_source/repo/cart_repo.dart';
import 'package:fpdart/fpdart.dart';

class CartRepoImpl implements CartRepo {
  final CartDataSource cartDataSource;

  CartRepoImpl({required this.cartDataSource});

  @override
  Future<Either<Failure, Map<String, dynamic>>> addToCart({
    required String productId,
    required int quantity,
  }) async {
    return await cartDataSource.addToCart(
      productId: productId,
      quantity: quantity,
    );
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getCart() async {
    return await cartDataSource.getCart();
  }
}