import 'package:e_commerce_app/core/network/errors/failures.dart';
import 'package:e_commerce_app/domain/models/product_model.dart';
import 'package:e_commerce_app/domain/repos/products_repo.dart';
import 'package:e_commerce_app/infrastructure/data_source/abstraction/products_data_source.dart';
import 'package:fpdart/fpdart.dart';

class ProductsRepoImpl implements ProductsRepo{
  final ProductsDataSource productsDataSource;

  ProductsRepoImpl({required this.productsDataSource});
  @override
  Future<Either<Failure, ProductResponse>> getProducts() async{
    try{
      final response = await productsDataSource.getProducts();
      return response.fold((failure)=>Left(failure),
      (data)=>Right(ProductResponse.fromJson(data)));
    }
    catch(e){
      return Left(DataMappingFailure(msg: e.toString()));
    }
  }
    @override
  Future<Either<Failure, Product>> getProductById({required String id}) async{
    try{
      final response = await productsDataSource.getProductById(id:id);
      return response.fold((failure)=>Left(failure),
      (data)=>Right(Product.fromJson(data)));
    }
    catch(e){
      return Left(DataMappingFailure(msg: e.toString()));
    }

  }
}