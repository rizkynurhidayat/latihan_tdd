import 'package:dartz/dartz.dart';
import 'package:latihan_tdd/core/failure.dart';
import 'package:latihan_tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:latihan_tdd/features/number_trivia/domain/repositories/number_trivia_repositories.dart';

class GetConcreateNumberTrivia {
  final NumberTriviaRepositories repository;
  GetConcreateNumberTrivia(this.repository);

  Future<Either<Failure, NumberTrivia>> execute(int number) async {
    return await repository.getConcreateNumberTrivia(number);
  }
}
