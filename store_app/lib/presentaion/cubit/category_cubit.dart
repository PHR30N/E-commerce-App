import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/domain/repos/category_repo.dart';
import 'package:e_commerce_app/presentaion/cubit/category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoriesRepo categoryRepository;

  CategoryCubit(this.categoryRepository) : super(CategoryInitial());
  
 Future<void> getCategories() async {
    emit(CategoryLoading());

    final result = await categoryRepository.getCategories();

    result.fold(
      (failure) => emit(CategoryFailure(failure.msg)),
      (categories) => emit(CategoriesFetchSuccess(categories)),
    );
  }
  Future<void> getProductsByCategory(String category) async {
    emit(CategoryLoading());

    final result = await categoryRepository.getProductsByCategory(category);

    result.fold(
      (failure) => emit(CategoryFailure(failure.msg)),
      (products) => emit(CategorySuccess(products)),
    );
  }
}
