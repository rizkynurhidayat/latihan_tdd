import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latihan_tdd/features/number_trivia/domain/usecases/get_concreate_number_trivia.dart';
import 'package:latihan_tdd/features/number_trivia/domain/usecases/get_random_number_trivia.dart';

import 'NumberTrivia_event.dart';
import 'NumberTrivia_state.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreateNumberTrivia _getConcreateNumberTrivia;
  final GetRandomNumberTrivia _getRandomNumberTrivia;
  NumberTriviaBloc(this._getConcreateNumberTrivia, this._getRandomNumberTrivia)
      : super(NumberTriviaEmpty()) {
    on<OnNumberChanged>(
      (event, emit) async {
        final number = event.number;
        emit(NumberTriviaLoading());
        final result = await _getConcreateNumberTrivia.execute(number);
        result.fold(
          (failure) {
            emit(NumberTriviaError(failure.message));
          },
          (data) {
            emit(NumberTriviaHasData(data));
          },
        );
      },
    );
    on<OnRandom>((event, emit) async {
      emit(NumberTriviaLoading());
      final result = await _getRandomNumberTrivia.execute();
      result.fold(
        (failure) {
          emit(NumberTriviaError(failure.message));
        },
        (data) {
          emit(NumberTriviaHasData(data));
        },
      );
    });
  }
}
