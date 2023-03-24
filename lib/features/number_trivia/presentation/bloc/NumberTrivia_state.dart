import 'package:equatable/equatable.dart';
import 'package:latihan_tdd/features/number_trivia/domain/entities/number_trivia.dart';

abstract class NumberTriviaState extends Equatable {
  NumberTriviaState();

  @override
  List<Object> get props => [];
}

/// UnInitialized
class NumberTriviaEmpty extends NumberTriviaState {}

class NumberTriviaLoading extends NumberTriviaState {}

/// Initialized
class NumberTriviaHasData extends NumberTriviaState {
  NumberTriviaHasData(this.result);

  final NumberTrivia result;

  @override
  List<Object> get props => [result];
}

class NumberTriviaError extends NumberTriviaState {
  NumberTriviaError(this.errorMessage);

  final String errorMessage;

  @override
  String toString() => 'ErrorNumberTriviaState';

  @override
  List<Object> get props => [errorMessage];
}
