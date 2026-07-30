import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/domain/models/product_model.dart';
import 'package:e_commerce_app/domain/repos/products_repo.dart';
import '../../presentaion/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required this.productsRepo}) : super(HomeInitialState());

  final ProductsRepo productsRepo;

  Future<void> getProducts() async {
    emit(GetProductsLoadingState());
    final response = await productsRepo.getProducts();
    response.fold(
      (failure) => emit(GetProductsFailureState(message: failure.msg)),
      (data) => emit(GetProductsSuccessState(response: data)),
    );
  }

  Future<void> getProductById({required String id}) async {
    ProductResponse? currentResponse;
    if (state is GetProductsSuccessState) {
      currentResponse = (state as GetProductsSuccessState).response;
      emit(GetProductByIdLoadingState(response: currentResponse));
    } else {
      emit(GetProductsLoadingState());
    }

    final product = await productsRepo.getProductById(id: id);

    product.fold(
      (failure) {
        if (currentResponse != null) {
          emit(GetProductByIdFailureState(
              message: failure.msg, response: currentResponse));
        } else {
          emit(GetProductsFailureState(message: failure.msg));
        }
      },
      (data) {
        if (currentResponse != null) {
          emit(GetProductByIdSuccessState(
              response: currentResponse, product: data));
        } else {
          emit(GetProductByIdSuccessState(
            response: ProductResponse(
              items: [data],
              page: 1,
              pageSize: 1,
              totalCount: 1,
              hasNextPage: false,
              hasPreviousPage: false,
            ),
            product: data,
          ));
        }
      },
    );
  }
}