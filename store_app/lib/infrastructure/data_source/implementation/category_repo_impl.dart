import 'package:e_commerce_app/core/network/errors/failures.dart';
import 'package:e_commerce_app/domain/models/category_model.dart';
import 'package:e_commerce_app/domain/models/product_model.dart';
import 'package:e_commerce_app/domain/repos/category_repo.dart';
import 'package:e_commerce_app/infrastructure/data_source/abstraction/category_data_source.dart';
import 'package:fpdart/fpdart.dart';

class CategoriesRepoImpl implements CategoriesRepo {
  final CategoriesDataSource categoriesDataSource;

  CategoriesRepoImpl({required this.categoriesDataSource});

  @override
  Future<Either<Failure, List<CategoryModel>>> getCategories() async {
    try {
      final result = await categoriesDataSource.getCategories();

      return result.fold(
        (failure) => Left(failure),
        (data) {
          // Cast data as dynamic so we can safely check if it's a Map or List
          final dynamic rawData = data;
          List<dynamic> listData = [];

          if (rawData is List && rawData.isNotEmpty) {
            if (rawData.first is Map && rawData.first['categories'] != null) {
              listData = rawData.first['categories'] as List<dynamic>;
            } else {
              listData = rawData;
            }
          } else if (rawData is Map) {
            if (rawData['categories'] != null) {
              listData = rawData['categories'] as List<dynamic>;
            } else if (rawData['data'] != null) {
              listData = rawData['data'] as List<dynamic>;
            }
          }

          final categories = listData
              .map((e) => e is Map<String, dynamic>
                  ? CategoryModel.fromJson(e)
                  : CategoryModel.fromApiString(e.toString()))
              .toList();

          return Right(categories);
        },
      );
    } catch (e) {
      return Left(ServerFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getProductsByCategory(
      String category) async {
    try {
      final result = await categoriesDataSource.getProductsByCategory(category);

      return result.fold(
        (failure) => Left(failure),
        (data) {
          final dynamic rawData = data;
          List<dynamic> listData = [];

          if (rawData is List) {
            listData = rawData;
          } else if (rawData is Map) {
            if (rawData['products'] != null) {
              listData = rawData['products'] as List<dynamic>;
            } else if (rawData['data'] != null) {
              listData = rawData['data'] as List<dynamic>;
            }
          }

          final products = listData
              .map((e) => Product.fromJson(e as Map<String, dynamic>))
              .toList();

          return Right(products);
        },
      );
    } catch (e) {
      return Left(ServerFailure(msg: e.toString()));
    }
  }
}