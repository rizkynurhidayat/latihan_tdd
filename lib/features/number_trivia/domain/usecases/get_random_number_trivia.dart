import 'package:dartz/dartz.dart';
import 'package:latihan_tdd/core/failure.dart';
import 'package:latihan_tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:latihan_tdd/features/number_trivia/domain/repositories/number_trivia_repositories.dart';

class GetRandomNumberTrivia {
  final NumberTriviaRepositories repositories;
  GetRandomNumberTrivia(this.repositories);

  Future<Either<Failure, NumberTrivia>> execute() async {
    return await repositories.getRandomNumberTrivia();
  }
}
