import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:latihan_tdd/core/exeption.dart';
import 'package:latihan_tdd/core/failure.dart';

import 'package:latihan_tdd/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:latihan_tdd/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:latihan_tdd/features/number_trivia/domain/entities/number_trivia.dart';

import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import '../../../core/test_helper.mocks.dart';

void main() {
  late MockRemoteDataSource mockRemoteDataSource;
  late NumberTriviaRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    repository =
        NumberTriviaRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });
  final tNumberTriviaModel = NumberTriviaModel(number: 1, text: 'test');
  final tNumberTrivia = NumberTrivia(number: 1, text: 'test');

  group('get current Number', () {
    final tNumber = 1;
    test(
        'should return current Number when a call to data source is successful',
        () async {
      //arrange
      when(mockRemoteDataSource.getConcreateNumberTrivia(tNumber))
          .thenAnswer((_) async => tNumberTriviaModel);
      //act
      final result = await repository.getConcreateNumberTrivia(tNumber);
      //assert
      verify(mockRemoteDataSource.getConcreateNumberTrivia(tNumber));
      expect(result, equals(Right(tNumberTrivia)));
    });

    test('should return server failure when a call data is unsucsesful',
        () async {
      //arrange
      when(mockRemoteDataSource.getConcreateNumberTrivia(tNumber))
          .thenThrow(ServerException());
      //act
      final result = await repository.getConcreateNumberTrivia(tNumber);
      //assert
      verify(mockRemoteDataSource.getConcreateNumberTrivia(tNumber));
      expect(result, equals(left(ServerFailure(''))));
    });

    test('should return connection failure when the device has no internet',
        () async {
//arrange
      when(mockRemoteDataSource.getConcreateNumberTrivia(tNumber))
          .thenThrow(SocketException('Failed to connect internet'));
//act
      final result = await repository.getConcreateNumberTrivia(tNumber);
//assert
      verify(mockRemoteDataSource.getConcreateNumberTrivia(tNumber));
      expect(result,
          equals(left(ConnectionFailure('Failed to connect internet'))));
    });
  });
}
