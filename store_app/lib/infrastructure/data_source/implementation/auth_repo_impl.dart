import 'package:e_commerce_app/infrastructure/data_source/repo/auth_repo.dart';
import 'package:e_commerce_app/core/network/apis/end_points.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/network/apis/api_consumer.dart';
import '../../../../core/network/errors/failures.dart';

class AuthRepoImpl implements AuthRepo {
  final ApiConsumer apiConsumer;

  AuthRepoImpl({required this.apiConsumer});

  @override
  Future<Either<ServerFailure, Map<String, dynamic>>> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    return await apiConsumer.post(
      path: "/auth/register",

      body: {
        "email": email,

        "password": password,

        "firstName": firstName,

        "lastName": lastName,
      },
    );
  }

  @override
  Future<Either<ServerFailure, Map<String, dynamic>>> verifyEmail({
    required String email,

    required String otp,
  }) async {
    return await apiConsumer.post(
      path: EndPoints.verifyEmail,

      body: {"email": email, "otp": otp},
    );
  }
}
