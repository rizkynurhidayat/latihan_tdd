import 'package:dartz/dartz.dart';
import 'package:latihan_tdd/core/failure.dart';

import '../entities/number_trivia.dart';

abstract class NumberTriviaRepositories {
  Future<Either<Failure, NumberTrivia>> getConcreateNumberTrivia(int number);
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia();
}
