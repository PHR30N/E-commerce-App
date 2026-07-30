import 'package:e_commerce_app/core/constant/local_key.dart';
import 'package:e_commerce_app/core/local_storage/base_local_storage.dart';
import 'package:e_commerce_app/infrastructure/data_source/repo/auth_repo.dart';
import 'package:e_commerce_app/presentaion/cubit/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;
  final BaseLocalStorage localStorage;

  AuthCubit({required this.authRepo, required this.localStorage}):super(AuthInitial());
Future<void> verify({
    required String email,
    required String otp,
  })async{
emit(AuthLoading());
    final response = await authRepo.verify(email: email, otp: otp);
    response.fold((failure)=>emit(AuthFailure(message: failure.msg)),
     (data)=>emit(VerifySuccess()));
  }
  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    final response = await authRepo.login(email: email, password: password);
    await response.fold(
      (failure) async {
        print("🔴 LOGIN FAILED: ${failure.msg}");
        emit(AuthFailure(message: failure.msg));
      },
      (data) async {
        print("🟢 LOGIN API RESPONSE DATA: $data");
        final dynamic rawData = data['data'] ?? data;
        final String token = (rawData is Map)
            ? (rawData['accessToken'] ?? rawData['token'] ?? '').toString()
            : '';
        await localStorage.setString(LocalKey.email, email);
        await localStorage.setString(LocalKey.token, token);

        print("💾 SAVING TOKEN: '$token'");

        emit(LoginSuccess(token: token));
      },
    );
  }
  Future<void> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  })async{
    emit(AuthLoading());
    final response = await authRepo.register(email: email, password: password, firstName: firstName, lastName: lastName);
    response.fold((failure)=>emit(AuthFailure(message: failure.msg)),
     (data)=>emit(RegisterSuccess(email: email)));
  }

}