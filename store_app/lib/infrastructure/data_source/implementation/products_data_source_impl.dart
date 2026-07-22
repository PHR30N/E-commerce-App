import 'package:e_commerce_app/core/network/apis/api_consumer.dart';
import 'package:e_commerce_app/core/network/apis/end_points.dart';
import 'package:e_commerce_app/core/network/errors/failures.dart';
import 'package:e_commerce_app/infrastructure/data_source/abstraction/products_data_source.dart';
import 'package:fpdart/fpdart.dart';

class ProductsDataSourceImpl implements ProductsDataSource {
  final ApiConsumer apiConsumer;

  ProductsDataSourceImpl({required this.apiConsumer});
  @override
  Future<Either<Failure, Map<String, dynamic>>> getProducts() async {
    try{
      final response = await apiConsumer.get(path: EndPoints.products);
      return response.fold((failure)=>Left(ServerFailure(msg: failure.msg)), 
      (data)=>Right(data));
    }
    catch(e){return Left(ServerFailure(msg: e.toString()));}
  }
  @override
  Future<Either<Failure, Map<String, dynamic>>> getProductById({required String id}) async {
    try{
      final response = await apiConsumer.get(path: "${EndPoints.products}/$id");
      return response.fold((failure)=>Left(ServerFailure(msg: failure.msg)), 
      (data)=>Right(data));
    }
    catch(e){return Left(ServerFailure(msg: e.toString()));}
  }
}