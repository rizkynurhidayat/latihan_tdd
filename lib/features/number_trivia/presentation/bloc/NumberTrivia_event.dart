import 'dart:async';
import 'dart:developer' as developer;

import 'package:equatable/equatable.dart';

import 'package:meta/meta.dart';

@immutable
abstract class NumberTriviaEvent extends Equatable {
  const NumberTriviaEvent();
  @override
  List<Object?> get props => [];
}

class OnNumberChanged extends NumberTriviaEvent {
  final int number;

  OnNumberChanged(this.number);

  @override
  List<Object?> get props => [number];
}

class OnRandom extends NumberTriviaEvent {}
