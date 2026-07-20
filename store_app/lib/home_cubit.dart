import 'package:bloc/bloc.dart';
import 'api_service.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState>{
  HomeCubit({required this.apiService}):super(HomeInitialState());
  final ApiService apiService;
  Future<void> getProducts() async {
    emit(GetProductsLoadingState());
    try{
      final response = await apiService.getProducts();
      emit(GetProductsSuccessState(response: response));
    }catch(e){
      emit(GetProductsFailureState(message: e.toString()));
    }
  }
  Future<void> getProductById({required String id}) async {
    switch(state){
      case GetProductsSuccessState(:final response):
        emit(GetProductByIdLoadingState(response: response));
        try{
          final product = await apiService.getProductById(id: id);
          emit(GetProductByIdSuccessState(product: product, response: response));
        }catch(e){
          emit(GetProductByIdFailureState(message: e.toString(), response: response));
        }
        default:
        break;
    }
  }
}


