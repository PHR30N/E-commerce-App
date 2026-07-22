import 'package:e_commerce_app/core/network/errors/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract class ProductsDataSource {
  Future<Either<Failure,Map<String,dynamic>>> getProducts();
  Future<Either<Failure,Map<String,dynamic>>> getProductById({required String id});

  


}