import 'package:e_commerce_app/domain/models/cart_model.dart';
import 'package:e_commerce_app/infrastructure/data_source/repo/cart_repo.dart';
import 'package:e_commerce_app/presentaion/cubit/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepo cartRepo;

  CartCubit({required this.cartRepo}) : super(CartInitial());

  Future<void> addToCart({
    required String productId,
    int quantity = 1,
  }) async {
    emit(CartLoading());
    final response = await cartRepo.addToCart(
      productId: productId,
      quantity: quantity,
    );
    response.fold(
      (failure) => emit(CartFailure(message: failure.msg)),
      (data) => emit(AddToCartSuccess(message: "Item added to cart")),
    );
  }

  Future<void> getCart() async {
  emit(CartLoading());
  final response = await cartRepo.getCart();
  response.fold(
    (failure) => emit(CartFailure(message: failure.msg)),
    (data) {
      try {
        dynamic rawData = data;
        if (data is Map && data.containsKey('data')) {
          rawData = data['data'];
        }

        if (rawData is Map) {
          final cart = CartModel.fromJson(Map<String, dynamic>.from(rawData));
          emit(GetCartSuccess(cart: cart));
        } else {
          emit(CartFailure(message: "Invalid cart data format received."));
        }
      } catch (e) {
        emit(CartFailure(message: e.toString()));
      }
    },
  );
}
}
