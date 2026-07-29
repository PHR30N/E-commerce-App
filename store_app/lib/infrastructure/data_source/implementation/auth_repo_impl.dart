import 'package:e_commerce_app/infrastructure/data_source/abstraction/auth_data_source.dart';
import 'package:e_commerce_app/infrastructure/data_source/repo/auth_repo.dart';
import 'package:e_commerce_app/core/network/apis/end_points.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/network/apis/api_consumer.dart';
import '../../../../core/network/errors/failures.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthDataSource authDataSource;

  AuthRepoImpl({required this.authDataSource});

  @override
  Future<Either<Failure, Map<String, dynamic>>> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    try {
      final response = await authDataSource.register(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,);

      return response.fold(
  (failure) => Left(ServerFailure(msg:failure.msg)),
  (data) => Right((data)),
);
    } catch (e) {
      return Left(DataMappingFailure(msg: e.toString()));
    }
  }
@override
  Future<Either<Failure, Map<String, dynamic>>> login({
    required String email,
    required String password,
  })async{
    try {
      final response = await authDataSource.login(
        email: email,
        password: password,);

      return response.fold(
  (failure) => Left(ServerFailure(msg:failure.msg)),
  (data) => Right((data)),
);
    } catch (e) {
      return Left(DataMappingFailure(msg: e.toString()));
    }
  }
  @override
  Future<Either<Failure, Map<String, dynamic>>> verify({
    required String email,

    required String otp,
  }) async {
    try {
      final response = await authDataSource.verify(
        email: email,
        otp: otp);

      return response.fold(
  (failure) => Left(ServerFailure(msg:failure.msg)),
  (data) => Right((data)),
);
    } catch (e) {
      return Left(DataMappingFailure(msg: e.toString()));
    }
  }
}