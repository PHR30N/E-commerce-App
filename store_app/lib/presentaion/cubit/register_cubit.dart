import 'package:e_commerce_app/infrastructure/data_source/repo/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {

  final AuthRepo authRepo;

  RegisterCubit(this.authRepo)
      : super(RegisterInitial());


  Future<void> register({

    required String email,

    required String password,

    required String firstName,

    required String lastName,

  }) async {


    emit(RegisterLoading());


    final result = await authRepo.register(

      email: email,

      password: password,

      firstName: firstName,

      lastName: lastName,

    );


    result.fold(

      (failure) {

        emit(
          RegisterFailure(
            failure.msg,
          ),
        );

      },


      (data) {

        emit(
          RegisterSuccess(
            data["message"] ??
                "Registration successful",
          ),
        );

      },

    );

  }

}