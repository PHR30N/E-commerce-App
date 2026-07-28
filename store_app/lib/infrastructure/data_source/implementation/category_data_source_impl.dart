import 'package:e_commerce_app/core/network/apis/api_consumer.dart';
import 'package:e_commerce_app/core/network/apis/end_points.dart';
import 'package:e_commerce_app/core/network/errors/failures.dart';
import 'package:e_commerce_app/infrastructure/data_source/abstraction/category_data_source.dart';
import 'package:fpdart/fpdart.dart';

class CategoriesDataSourceImpl implements CategoriesDataSource {
  final ApiConsumer apiConsumer;

  CategoriesDataSourceImpl({required this.apiConsumer});

  @override
  Future<Either<Failure, Map<String, dynamic>>> getCategories() async {
    try {
      final response = await apiConsumer.get(path: EndPoints.categories);
      return response.fold(
        (failure) => Left(ServerFailure(msg: failure.msg)),
        (data) => Right(data),
      );
    } catch (e) {
      return Left(ServerFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getProductsByCategory(
      String category) async {
    try {
      final response = await apiConsumer.get(
        path: "${EndPoints.categories}/$category",
      );
      return response.fold(
        (failure) => Left(ServerFailure(msg: failure.msg)),
        (data) => Right(data),
      );
    } catch (e) {
      return Left(ServerFailure(msg: e.toString()));
    }
  }
}