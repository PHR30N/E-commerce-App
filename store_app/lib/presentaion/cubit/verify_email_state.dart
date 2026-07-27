import 'package:equatable/equatable.dart';

abstract class VerifyEmailState extends Equatable {

  const VerifyEmailState();

  @override
  List<Object?> get props => [];

}


class VerifyEmailInitial extends VerifyEmailState {}


class VerifyEmailLoading extends VerifyEmailState {}


class VerifyEmailSuccess extends VerifyEmailState {

  final String message;

  const VerifyEmailSuccess(this.message);


  @override
  List<Object?> get props => [message];

}



class VerifyEmailFailure extends VerifyEmailState {

  final String message;

  const VerifyEmailFailure(this.message);


  @override
  List<Object?> get props => [message];

}