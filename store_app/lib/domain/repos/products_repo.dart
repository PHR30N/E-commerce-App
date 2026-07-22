import 'package:e_commerce_app/core/network/errors/failures.dart';
import 'package:e_commerce_app/domain/models/product_model.dart';
import 'package:fpdart/fpdart.dart';

abstract class ProductsRepo {
  Future<Either<Failure,ProductResponse>> getProducts();
  Future<Either<Failure,Product>> getProductById({required String id});
}