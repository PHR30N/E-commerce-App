import 'Product_Model.dart';

class HomeState{}

class HomeInitialState extends HomeState{}
class GetProductsLoadingState extends HomeState{}
class GetProductsSuccessState extends HomeState{
  final ProductResponse response;
  GetProductsSuccessState({required this.response});
} 
class GetProductsFailureState extends HomeState{
  final String message;
  GetProductsFailureState({this.message = "Failed to get products"});
}
class GetProductByIdLoadingState extends GetProductsSuccessState{
  GetProductByIdLoadingState({required super.response});
}
class GetProductByIdSuccessState extends GetProductsSuccessState{
  final Product product;
  GetProductByIdSuccessState({required this.product, required super.response});
}
class GetProductByIdFailureState extends GetProductsSuccessState{
  final String message;
  GetProductByIdFailureState({this.message = "Failed to get product by id", required super.response});
}

