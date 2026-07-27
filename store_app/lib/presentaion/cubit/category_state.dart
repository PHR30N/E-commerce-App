import '../../domain/models/product_model.dart';

abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategorySuccess extends CategoryState {

  final List<Product> products;

  CategorySuccess(this.products);

}

class CategoryFailure extends CategoryState {

  final String message;

  CategoryFailure(this.message);

}