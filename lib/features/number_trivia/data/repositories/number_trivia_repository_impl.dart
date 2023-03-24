import 'dart:io';

import 'package:latihan_tdd/core/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:latihan_tdd/features/number_trivia/data/datasources/remote_data_sources.dart';
import 'package:latihan_tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:latihan_tdd/features/number_trivia/domain/repositories/number_trivia_repositories.dart';

import '../../../../core/exeption.dart';

class NumberTriviaRepositoryImpl implements NumberTriviaRepositories {
  final RemoteDataSource remoteDataSource;
  NumberTriviaRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, NumberTrivia>> getConcreateNumberTrivia(
      int number) async {
    // TODO: implement getConcreateNumberTrivia
    try {
      final result = await remoteDataSource.getConcreateNumberTrivia(number);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect internet'));
    }
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    // TODO: implement getRandomNumberTrivia
    try {
      final result = await remoteDataSource.getRandomNumberTrivia();
      return Right(result.toEntity());
    } on ServerException {
      return left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect internet'));
    }
  }
}
