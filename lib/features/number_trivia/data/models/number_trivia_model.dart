import 'package:equatable/equatable.dart';

import '../../domain/entities/number_trivia.dart';

class NumberTriviaModel extends Equatable {
  final String text;
  final int number;

  NumberTriviaModel({required this.number, required this.text});
  factory NumberTriviaModel.fromJson(Map<String, dynamic> json) =>
      NumberTriviaModel(number: json["number"], text: json["text"]);

  NumberTrivia toEntity() => NumberTrivia(number: number, text: text);

  @override
  List<Object> get props => [text, number];
}
