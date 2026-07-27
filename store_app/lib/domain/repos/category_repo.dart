import 'package:e_commerce_app/core/network/errors/failures.dart';
import 'package:e_commerce_app/domain/models/category_model.dart';
import 'package:e_commerce_app/domain/models/product_model.dart';
import 'package:fpdart/fpdart.dart';

abstract class CategoriesRepo {

  Future<Either<Failure, List<CategoryModel>>> getCategories();

  Future<Either<Failure, List<Product>>> getProductsByCategory(
    String category,
  );

}