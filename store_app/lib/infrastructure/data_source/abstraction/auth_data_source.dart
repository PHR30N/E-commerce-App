import 'package:e_commerce_app/core/network/errors/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract class AuthDataSource {
  Future<Either<Failure,Map<String,dynamic>>> register({required String email,required String password,required String firstName,required String lastName});
  Future<Either<Failure,Map<String,dynamic>>> login({required String email,required String password});
  Future<Either<Failure,Map<String,dynamic>>> verify({required String email,required String otp});
}