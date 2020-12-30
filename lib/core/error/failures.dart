import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

// Genral failures
class ServerFailure extends Failure {}

class CacheFailure extends Failure {}
