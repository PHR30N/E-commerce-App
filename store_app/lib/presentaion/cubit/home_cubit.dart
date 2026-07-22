import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/domain/repos/products_repo.dart';
import '../../presentaion/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState>{
  HomeCubit({required this.productsRepo}):super(HomeInitialState());
  final ProductsRepo productsRepo;
  Future<void> getProducts() async {
    emit(GetProductsLoadingState());
      final response = await productsRepo.getProducts();
      response.fold((failure)=> emit(GetProductsFailureState(message: failure.msg)), 
      (data)=>emit(GetProductsSuccessState(response: data)));
    }
  Future<void> getProductById({required String id}) async {
    switch(state){
      case GetProductsSuccessState(:final response):
        emit(GetProductByIdLoadingState(response: response));
      final product = await productsRepo.getProductById(id:id);
      product.fold((failure)=> emit(GetProductByIdFailureState(message: failure.msg, response: response)), 
      (data)=>emit(GetProductByIdSuccessState(response: response, product: data)));
        default:
        break;
    }
  }
}


