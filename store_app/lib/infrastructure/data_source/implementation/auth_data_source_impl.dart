import 'package:e_commerce_app/core/network/apis/api_consumer.dart';
import 'package:e_commerce_app/core/network/apis/end_points.dart';
import 'package:e_commerce_app/core/network/errors/failures.dart';
import 'package:e_commerce_app/infrastructure/data_source/abstraction/auth_data_source.dart';
import 'package:fpdart/fpdart.dart';

class AuthDataSourceImpl extends AuthDataSource {
final ApiConsumer apiConsumer;

  AuthDataSourceImpl({required this.apiConsumer});

  @override
  Future<Either<Failure,Map<String,dynamic>>> register({required String email,required String password,required String firstName,required String lastName})async{
    try{final response = await apiConsumer.post(path: EndPoints.register,
    body: {'email':email,'password':password,'firstName':firstName,'lastName':lastName});
    return response.fold(
      (failure)=>Left(ServerFailure(msg: failure.msg)),
    (data)=>Right(data));
    }catch(e){return Left(ServerFailure(msg: e.toString()));}
  }
  @override
  Future<Either<Failure,Map<String,dynamic>>> login({required String email,required String password})async{
try{final response = await apiConsumer.post(path: EndPoints.login,
    body: {'email':email,'password':password});
    return response.fold(
      (failure)=>Left(ServerFailure(msg: failure.msg)),
    (data)=>Right(data));
    }catch(e){return Left(ServerFailure(msg: e.toString()));}
  }
  @override
  Future<Either<Failure,Map<String,dynamic>>> verify({required String email,required String otp})async{
try{final response = await apiConsumer.post(path: EndPoints.verify,
    body: {'email':email,'otp':otp});
    return response.fold(
      (failure)=>Left(ServerFailure(msg: failure.msg)),
    (data)=>Right(data));
    }catch(e){return Left(ServerFailure(msg: e.toString()));}
  }


}