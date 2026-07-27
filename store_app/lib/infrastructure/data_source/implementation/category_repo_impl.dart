import 'package:e_commerce_app/core/network/apis/aoi_service.dart';
import 'package:e_commerce_app/core/network/errors/failures.dart';

import 'package:e_commerce_app/domain/models/category_model.dart';
import 'package:e_commerce_app/domain/models/product_model.dart';
import 'package:e_commerce_app/domain/repos/category_repo.dart';



import 'package:fpdart/fpdart.dart';



class CategoriesRepoImpl extends CategoriesRepo {


  final ApiService apiService;



  CategoriesRepoImpl({
    required this.apiService,
  });



  @override
  Future<Either<Failure, List<CategoryModel>>> getCategories() async {

    try {


      final result =
      await apiService.fetchCategories();



      if(result.isSuccess){

        return Right(
          result.data!,
        );

      }


      return Left(

        ServerFailure(
          msg: result.error ?? "Unknown Error",
        ),

      );


    }catch(e){


      return Left(

        ServerFailure(
          msg: e.toString(),
        ),

      );

    }

  }




  @override
  Future<Either<Failure, List<Product>>> getProductsByCategory(
      String category,
      ) async {


    try {


      final products =
      await apiService.fetchProductsByCategory(
        category,
      );



      return Right(
        products,
      );


    }catch(e){


      return Left(

        ServerFailure(
          msg: e.toString(),
        ),

      );


    }


  }


}