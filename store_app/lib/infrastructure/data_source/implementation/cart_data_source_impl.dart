import 'package:e_commerce_app/core/network/apis/api_consumer.dart';
import 'package:e_commerce_app/core/network/apis/end_points.dart';
import 'package:e_commerce_app/core/network/errors/failures.dart';
import 'package:e_commerce_app/infrastructure/data_source/abstraction/cart_data_source.dart';
import 'package:fpdart/fpdart.dart';
class CartDataSourceImpl implements CartDataSource {
  final ApiConsumer apiConsumer;
  CartDataSourceImpl({required this.apiConsumer});
  @override
  Future<Either<Failure, Map<String, dynamic>>> getCart() async {
    try {
      final response = await apiConsumer.get(path: EndPoints.cart);
      return response.fold(
        (failure) => Left(ServerFailure(msg: failure.msg)),
        (data) => Right(data),
      );
    } catch (e) {
      return Left(ServerFailure(msg: e.toString()));
    }
  }
  @override
  Future<Either<Failure, Map<String, dynamic>>> addToCart({
    required String productId,
    required int quantity,
  }) async {
    try {
      final response = await apiConsumer.post(
        path: EndPoints.cartItems,
        body: {
          "productId": productId,
          "quantity": quantity,
        },
      );
      return response.fold(
        (failure) => Left(ServerFailure(msg: failure.msg)),
        (data) => Right(data),
      );
    } catch (e) {
      return Left(ServerFailure(msg: e.toString()));
    }
  }
  Future<Either<Failure, Map<String, dynamic>>> decrementCartItem({
    required String itemId,
    required int quantity,
  }) async {
    try {
      final response = await apiConsumer.post(
        path: EndPoints.cartDecrement,
        body: {
          "itemId": itemId,
          "quantity": quantity,
        },
      );
      return response.fold(
        (failure) => Left(ServerFailure(msg: failure.msg)),
        (data) => Right(data),
      );
    } catch (e) {
      return Left(ServerFailure(msg: e.toString()));
    }
  }
  Future<Either<Failure, Map<String, dynamic>>> updateCartItem({
    required String id,
    required int quantity,
  }) async {
    try {
      final response = await apiConsumer.put(
        path: EndPoints.cartItemById(id),
        body: {
          "id": id,
          "quantity": quantity,
        },
      );
      return response.fold(
        (failure) => Left(ServerFailure(msg: failure.msg)),
        (data) => Right(data),
      );
    } catch (e) {
      return Left(ServerFailure(msg: e.toString()));
    }
  }
  Future<Either<Failure, Map<String, dynamic>>> deleteCartItem({
    required String id,
  }) async {
    try {
      final response = await apiConsumer.delete(
        path: EndPoints.cartItemById(id),
        body: {"id": id},
      );
      return response.fold(
        (failure) => Left(ServerFailure(msg: failure.msg)),
        (data) => Right(data),
      );
    } catch (e) {
      return Left(ServerFailure(msg: e.toString()));
    }
  }
}