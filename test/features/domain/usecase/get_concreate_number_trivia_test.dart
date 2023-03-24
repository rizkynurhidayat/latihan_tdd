import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latihan_tdd/features/number_trivia/domain/entities/number_trivia.dart';

import 'package:latihan_tdd/features/number_trivia/domain/usecases/get_concreate_number_trivia.dart';

import 'package:mockito/mockito.dart';
import '../../../core/test_helper.mocks.dart';

void main() {
  late MockNumberTriviaRepositories mockNumberTriviaRepository;
  late GetConcreateNumberTrivia usecase;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepositories();
    usecase = GetConcreateNumberTrivia(mockNumberTriviaRepository);
  });

  const tNumber = 1;
  const tNUmberTrivia = NumberTrivia(number: 1, text: 'test');
  test('should get current number trivia from repository', () async {
// arange
    when(mockNumberTriviaRepository.getConcreateNumberTrivia(tNumber))
        .thenAnswer((_) async => const Right(tNUmberTrivia));
//act
    final result = await usecase.execute(tNumber);
//assert

    expect(result, equals(const Right(tNUmberTrivia)));
    verify(mockNumberTriviaRepository.getConcreateNumberTrivia(tNumber));
    verifyNoMoreInteractions(mockNumberTriviaRepository);
  });
}
