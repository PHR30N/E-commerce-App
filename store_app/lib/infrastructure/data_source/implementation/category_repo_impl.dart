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

  List<dynamic> _extractList(dynamic input) {
    if (input is List) {
      if (input.isEmpty) return [];
      if (input.first is Map) {
        final firstMap = input.first as Map;
        if (firstMap.containsKey('categories')) return firstMap['categories'] as List;
        if (firstMap.containsKey('Categories')) return firstMap['Categories'] as List;
        if (firstMap.containsKey('data')) return _extractList(firstMap['data']);
        if (firstMap.containsKey('Data')) return _extractList(firstMap['Data']);
      }
      return input;
    }

    if (input is Map) {
      if (input.containsKey('categories')) return _extractList(input['categories']);
      if (input.containsKey('Categories')) return _extractList(input['Categories']);
      if (input.containsKey('data')) return _extractList(input['data']);
      if (input.containsKey('Data')) return _extractList(input['Data']);
      if (input.containsKey('items')) return _extractList(input['items']);
      if (input.containsKey('Items')) return _extractList(input['Items']);
      if (input.containsKey('result')) return _extractList(input['result']);
      if (input.containsKey('Result')) return _extractList(input['Result']);
    }

    return [];
  }

  @override
  Future<Either<Failure, List<CategoryModel>>> getCategories() async {
    try {
      final result = await categoriesDataSource.getCategories();

      return result.fold(
        (failure) => Left(failure),
        (data) {
          dynamic rawData = data['data'] ?? data;

          if (rawData is String) {
            try {
              rawData = jsonDecode(rawData);
            } catch (_) {}
          }

          // Print to debug console so you can see what the server returned
          print("📦 RAW CATEGORIES FROM SERVER: $rawData");

          final List<dynamic> listData = _extractList(rawData);

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

          final List<dynamic> listData = _extractList(rawData);

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