import 'package:dartz/dartz.dart';

import '../../../../core/error/Failures.dart';
import '../entities/number_trivia.dart';

// 다음 레이어(data)와 아래 계약만 지키면 독립적으로 구현이 가능함
abstract class NumberTriviaRepository {
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number);
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia();
}
