import 'package:e_commerce_app/core/network/errors/failures.dart';

import 'package:e_commerce_app/domain/models/product_model.dart';

import 'package:e_commerce_app/domain/repos/products_repo.dart';

import 'package:e_commerce_app/infrastructure/data_source/abstraction/products_data_source.dart';
import 'package:fpdart/fpdart.dart';

class ProductsRepoImpl extends ProductsRepo {
  final ProductsDataSource productsDataSource;

  ProductsRepoImpl({required this.productsDataSource});

  @override
  Future<Either<Failure, ProductResponse>> getProducts() async {
    try {
      final products = await productsDataSource.getProducts();

      return Right(products as ProductResponse);
    } catch (e) {
      return Left(ServerFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Product>> getProductById({required String id}) async {
    try {
      final product = await productsDataSource.getProductById(id: id);

      return Right(product as Product);
    } catch (e) {
      return Left(ServerFailure(msg: e.toString()));
    }
  }
}
