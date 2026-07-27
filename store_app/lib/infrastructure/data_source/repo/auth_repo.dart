import 'package:e_commerce_app/infrastructure/data_source/implementation/auth_repo_impl.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/network/errors/failures.dart';

abstract class AuthRepo {
  Future<Either<ServerFailure, Map<String, dynamic>>> verifyEmail({
    required String email,
    required String otp,
  });
  Future<Either<ServerFailure, Map<String, dynamic>>> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  });
}

