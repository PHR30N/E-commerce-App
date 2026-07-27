import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../infrastructure/data_source/repo/auth_repo.dart';
import 'verify_email_state.dart';


class VerifyEmailCubit extends Cubit<VerifyEmailState> {


  final AuthRepo authRepo;


  VerifyEmailCubit(this.authRepo)
      : super(VerifyEmailInitial());



  Future<void> verifyEmail({

    required String email,

    required String otp,

  }) async {


    emit(VerifyEmailLoading());



    final result = await authRepo.verifyEmail(

      email: email,

      otp: otp,

    );



    result.fold(

      (failure){

        emit(
          VerifyEmailFailure(
            failure.msg,
          ),
        );

      },


      (data){

        emit(
          VerifyEmailSuccess(
            data["message"] ??
            "Email verified successfully",
          ),
        );

      },

    );


  }


}