import 'dart:convert';
import 'package:e_commerce_app/core/network/errors/failures.dart';
import 'package:e_commerce_app/domain/models/category_model.dart';
import 'package:e_commerce_app/domain/models/product_model.dart';
import 'package:e_commerce_app/domain/repos/category_repo.dart';
import 'package:e_commerce_app/infrastructure/data_source/abstraction/category_data_source.dart';
import 'package:e_commerce_app/infrastructure/data_source/abstraction/products_data_source.dart';
import 'package:fpdart/fpdart.dart';

class CategoriesRepoImpl implements CategoriesRepo {
  final CategoriesDataSource categoriesDataSource;
  final ProductsDataSource productsDataSource;

  CategoriesRepoImpl({
    required this.categoriesDataSource,
    required this.productsDataSource,
  });

  List<dynamic> _extractList(dynamic input) {
    if (input == null) return [];

    if (input is List) {
      if (input.isEmpty) return [];
      if (input.first is Map) {
        final firstMap = input.first as Map;
        if (firstMap.containsKey('products')) return _extractList(firstMap['products']);
        if (firstMap.containsKey('Products')) return _extractList(firstMap['Products']);
        if (firstMap.containsKey('categories')) return _extractList(firstMap['categories']);
        if (firstMap.containsKey('Categories')) return _extractList(firstMap['Categories']);
        if (firstMap.containsKey('data')) return _extractList(firstMap['data']);
        if (firstMap.containsKey('Data')) return _extractList(firstMap['Data']);
      }
      return input;
    }

    if (input is Map) {
      if (input.containsKey('products')) return _extractList(input['products']);
      if (input.containsKey('Products')) return _extractList(input['Products']);
      if (input.containsKey('categories')) return _extractList(input['categories']);
      if (input.containsKey('Categories')) return _extractList(input['Categories']);
      if (input.containsKey('items')) return _extractList(input['items']);
      if (input.containsKey('Items')) return _extractList(input['Items']);
      if (input.containsKey('data')) return _extractList(input['data']);
      if (input.containsKey('Data')) return _extractList(input['Data']);
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
          dynamic rawData = data;
          if (data is Map && data.containsKey('data')) {
            rawData = data['data'];
          }

          if (rawData is String) {
            try {
              rawData = jsonDecode(rawData);
            } catch (_) {}
          }

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
      String categoryQuery) async {
    try {
      // 1. Try category endpoint
      final result = await categoriesDataSource.getProductsByCategory(categoryQuery);

      List<Product> products = [];

      result.fold(
        (_) {},
        (data) {
          dynamic rawData = data;
          if (data is Map && data.containsKey('data')) {
            rawData = data['data'];
          }

          if (rawData is String) {
            try {
              rawData = jsonDecode(rawData);
            } catch (_) {}
          }

          final List<dynamic> listData = _extractList(rawData);

          products = listData.map((e) {
            if (e is Map) {
              return Product.fromJson(Map<String, dynamic>.from(e));
            } else {
              return Product.fromJson({});
            }
          }).where((p) => p.id.isNotEmpty || p.name.isNotEmpty).toList();
        },
      );

      // 2. Fallback: Search all products by category name or ID
      final allProductsResult = await productsDataSource.getProducts();

      allProductsResult.fold(
        (_) {},
        (data) {
          final productResponse = ProductResponse.fromJson(data);
          final query = categoryQuery.toLowerCase().trim();

          final filteredFromAll = productResponse.items.where((p) {
            return p.categories.any((c) {
              final cLower = c.toLowerCase().trim();
              return cLower == query ||
                  cLower.contains(query) ||
                  query.contains(cLower) ||
                  c == categoryQuery;
            });
          }).toList();

          for (final p in filteredFromAll) {
            if (!products.any((existing) => existing.id == p.id)) {
              products.add(p);
            }
          }
        },
      );

      return Right(products);
    } catch (e) {
      return Left(ServerFailure(msg: e.toString()));
    }
  }
}