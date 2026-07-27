import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/presentaion/cubit/category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final dynamic categoryRepository;

  CategoryCubit(this.categoryRepository) : super(CategoryInitial());

  Future<void> getProductsByCategory(String category) async {
    emit(CategoryLoading());

    final result = await categoryRepository.getProductsByCategory(category);

    result.fold(
      (failure) => emit(CategoryFailure(failure.message)),
      (products) => emit(CategorySuccess(products)),
    );
  }
}
