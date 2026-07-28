import 'package:e_commerce_app/domain/models/category_model.dart';

import '../../domain/models/product_model.dart';

abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}
class CategoriesFetchSuccess extends CategoryState {
  final List<CategoryModel> categories;
  CategoriesFetchSuccess(this.categories);
}

class CategorySuccess extends CategoryState {

  final List<Product> products;

  CategorySuccess(this.products);

}

class CategoryFailure extends CategoryState {

  final String message;

  CategoryFailure(this.message);

}