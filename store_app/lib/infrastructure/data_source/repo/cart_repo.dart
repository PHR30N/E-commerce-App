import 'package:e_commerce_app/core/network/errors/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract class CartRepo {
  Future<Either<Failure, Map<String, dynamic>>> addToCart({
    required String productId,
    required int quantity,
  });
  Future<Either<Failure, Map<String, dynamic>>> getCart();
}