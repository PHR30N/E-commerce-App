import 'package:fpdart/fpdart.dart';
import '../../../../core/network/errors/failures.dart';

abstract class AuthRepo {
  Future<Either<Failure, Map<String, dynamic>>> verify({
    required String email,
    required String otp,
  });
  Future<Either<Failure, Map<String, dynamic>>> login({
    required String email,
    required String password,
  });
  Future<Either<Failure, Map<String, dynamic>>> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  });
}

