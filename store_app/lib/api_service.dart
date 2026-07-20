import 'dart:developer';

import 'package:dio/dio.dart';
import 'Product_Model.dart';

class ApiService{
    final Dio apiService = Dio(BaseOptions(
        baseUrl: 'https://accessories-eshop.runasp.net/api',
    ));
    Future<ProductResponse> getProducts() async {
      try{final response= await apiService.get('/products');
      if (response.statusCode == 200){
        return ProductResponse.fromJson(response.data as Map<String, dynamic>);
      }else{log(response.statusMessage.toString());
      return ProductResponse.fromJson({});
      }
      
      }
    on DioException catch (e) {
      log(e.message??"");
      return ProductResponse.fromJson({});
    }
  }
  Future<Product> getProductById({required String id}) async {
      try{final response= await apiService.get('/products/$id');
      if (response.statusCode == 200){
        return Product.fromJson(response.data as Map<String, dynamic>);
      }else{log(response.statusMessage.toString());
      return Product.fromJson({});
      }
      
      }
    on DioException catch (e) {
      log(e.message??"");
      return Product.fromJson({});
    }
  }
}