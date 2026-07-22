import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String msg;
  const Failure({required this.msg});
  @override
  List<Object?> get props => [msg];
}

class ServerFailure extends Failure {
  const ServerFailure({required super.msg});
}

class CacheFailure extends Failure {
  const CacheFailure({required super.msg});
}

class DataMappingFailure extends Failure {
  const DataMappingFailure({required super.msg});
}