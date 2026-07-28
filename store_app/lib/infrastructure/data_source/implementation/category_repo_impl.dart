import 'dart:convert';
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
          // 1. Unwrap from DioConsumer if wrapped in {'data': ...}
          dynamic rawData = data['data'] ?? data;

          if (rawData is String) {
            try {
              rawData = jsonDecode(rawData);
            } catch (_) {}
          }

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
            }
          }

          final categories = listData.map((e) {
            if (e is Map) {
              return CategoryModel.fromJson(Map<String, dynamic>.from(e));
            } else {
              final String str = e.toString();
              return CategoryModel(id: str, name: str);
            }
          }).toList();

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
          dynamic rawData = data['data'] ?? data;

          if (rawData is String) {
            try {
              rawData = jsonDecode(rawData);
            } catch (_) {}
          }

          List<dynamic> listData = [];

          if (rawData is List) {
            listData = rawData;
          } else if (rawData is Map) {
            if (rawData['products'] != null) {
              listData = rawData['products'] as List<dynamic>;
            }
          }

          final products = listData.map((e) {
            if (e is Map) {
              return Product.fromJson(Map<String, dynamic>.from(e));
            } else {
              return Product.fromJson({});
            }
          }).toList();

          return Right(products);
        },
      );
    } catch (e) {
      return Left(ServerFailure(msg: e.toString()));
    }
  }
}