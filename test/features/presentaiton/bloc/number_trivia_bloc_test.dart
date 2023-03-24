import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latihan_tdd/core/failure.dart';
import 'package:latihan_tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:latihan_tdd/features/number_trivia/domain/usecases/get_concreate_number_trivia.dart';
import 'package:latihan_tdd/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:latihan_tdd/features/number_trivia/presentation/bloc/NumberTrivia_bloc.dart';
import 'package:latihan_tdd/features/number_trivia/presentation/bloc/NumberTrivia_event.dart';
import 'package:latihan_tdd/features/number_trivia/presentation/bloc/NumberTrivia_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'number_trivia_bloc_test.mocks.dart';

@GenerateMocks([GetConcreateNumberTrivia, GetRandomNumberTrivia])
void main() {
  late MockGetConcreateNumberTrivia mockGetConcreateNumber;
  late MockGetRandomNumberTrivia mockGetRandomNumber;
  late NumberTriviaBloc numberTriviaBloc;

  setUp(() {
    mockGetConcreateNumber = MockGetConcreateNumberTrivia();
    mockGetRandomNumber = MockGetRandomNumberTrivia();
    numberTriviaBloc =
        NumberTriviaBloc(mockGetConcreateNumber, mockGetRandomNumber);
  });
  const tNumberTrivia = NumberTrivia(text: 'test', number: 1);
  const tNumber = 1;
  test('init state shoulbe emty', () {
    expect(numberTriviaBloc.state, NumberTriviaEmpty());
  });

  blocTest<NumberTriviaBloc, NumberTriviaState>(
    'should emit [loading, has data] when data is gotten successfully [concreate number]',
    build: () {
      when(mockGetConcreateNumber.execute(tNumber))
          .thenAnswer((_) async => Right(tNumberTrivia));
      return numberTriviaBloc;
    },
    act: (bloc) => bloc.add(OnNumberChanged(tNumber)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      NumberTriviaLoading(),
      NumberTriviaHasData(tNumberTrivia),
    ],
    verify: (bloc) {
      verify(mockGetConcreateNumber.execute(tNumber));
    },
  );

  blocTest<NumberTriviaBloc, NumberTriviaState>(
    'should emit [loading, error] when get data is unsuccessful [concreate number]',
    build: () {
      when(mockGetConcreateNumber.execute(tNumber))
          .thenAnswer((_) async => Left(ServerFailure('Server failure')));
      return numberTriviaBloc;
    },
    act: (bloc) => bloc.add(OnNumberChanged(tNumber)),
    expect: () => [
      NumberTriviaLoading(),
      NumberTriviaError('Server failure'),
    ],
    verify: (bloc) {
      verify(mockGetConcreateNumber.execute(tNumber));
    },
  );

  blocTest<NumberTriviaBloc, NumberTriviaState>(
    'should emit [loading, has data] when data is gotten successfully [random number]',
    build: () {
      when(mockGetRandomNumber.execute())
          .thenAnswer((_) async => Right(tNumberTrivia));
      return numberTriviaBloc;
    },
    act: (bloc) => bloc.add(OnRandom()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      NumberTriviaLoading(),
      NumberTriviaHasData(tNumberTrivia),
    ],
    verify: (bloc) {
      verify(mockGetRandomNumber.execute());
    },
  );

  blocTest<NumberTriviaBloc, NumberTriviaState>(
    'should emit [loading, error] when get data is unsuccessful [random number]',
    build: () {
      when(mockGetRandomNumber.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server failure')));
      return numberTriviaBloc;
    },
    act: (bloc) => bloc.add(OnRandom()),
    expect: () => [
      NumberTriviaLoading(),
      NumberTriviaError('Server failure'),
    ],
    verify: (bloc) {
      verify(mockGetRandomNumber.execute());
    },
  );
}
