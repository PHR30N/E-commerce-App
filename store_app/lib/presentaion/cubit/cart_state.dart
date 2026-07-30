import 'package:e_commerce_app/domain/models/cart_model.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class AddToCartSuccess extends CartState {
  final String message;

  AddToCartSuccess({required this.message});
}

class GetCartSuccess extends CartState {
  final CartModel cart;

  GetCartSuccess({required this.cart});
}

class CartFailure extends CartState {
  final String message;

  CartFailure({required this.message});
}