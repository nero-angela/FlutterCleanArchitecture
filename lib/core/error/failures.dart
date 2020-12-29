import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final List properties;
  Failure([this.properties = const <dynamic>[]]);

  @override
  List<Object> get props => properties;
}

// Genral failures
class ServerFailure extends Failure {}

class CacheFailure extends Failure {}
