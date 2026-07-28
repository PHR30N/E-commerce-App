import 'package:e_commerce_app/core/network/errors/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract class CategoriesDataSource {
  Future<Either<Failure, Map<String, dynamic>>> getCategories();
  Future<Either<Failure, Map<String, dynamic>>> getProductsByCategory(String category);
}