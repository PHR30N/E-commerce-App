import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:e_commerce_app/core/network/apis/local_storage.dart';
import 'package:e_commerce_app/domain/models/category_model.dart';
import 'package:e_commerce_app/domain/models/product_model.dart';

class ApiResult<T> {
  final T? data;
  final String? error;

  const ApiResult.success(this.data) : error = null;

  const ApiResult.failure(this.error) : data = null;

  bool get isSuccess => error == null;
}

class ApiService {
  ApiService._();
  static final ApiService instance = ApiService._();
  static const String baseUrl = "https://accessories-eshop.runasp.net";
  static const Duration timeout = Duration(seconds: 50);
  Future<ApiResult<List<CategoryModel>>> fetchCategories() async {
    try {
      final response = await http
          .get(Uri.parse("$baseUrl/products/categories"))
          .timeout(timeout);

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);

        final categories = data
            .map((e) => CategoryModel.fromApiString(e.toString()))
            .toList();

        return ApiResult.success(categories);
      }

      return ApiResult.failure("Server Error");
    } catch (e) {
      return ApiResult.failure(e.toString());
    }
  }

  // Products By Category
  Future<List<Product>> fetchProductsByCategory(String category) async {
    try {
      final response = await http
          .get(Uri.parse("$baseUrl/api/categories/$category"))
          .timeout(timeout);

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);

        final products = data.map((e) => Product.fromJson(e)).toList();

        return products;
      }

      throw Exception("Server Error ${response.statusCode}");
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
