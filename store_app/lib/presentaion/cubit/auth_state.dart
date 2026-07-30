abstract class AuthState{}
class AuthInitial extends AuthState{}
class AuthLoading extends AuthState{}
class RegisterSuccess extends AuthState{
  final String email;
  RegisterSuccess({required this.email});
}
class VerifySuccess extends AuthState{}
class LoginSuccess extends AuthState{
  final String token;

  LoginSuccess({required this.token});
}
class AuthFailure extends AuthState{
  final String message;

  AuthFailure({required this.message});
}



