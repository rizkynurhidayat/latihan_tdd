import 'dart:convert';

import 'package:latihan_tdd/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:latihan_tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../core/json_reader.dart';

void main() {
  final tNumberTriviaModel =
      NumberTriviaModel(number: 42, text: "42 is boring number");

  const tNumberTrivia = NumberTrivia(text: '42 is boring number', number: 42);

  group('to entitiy', () {
    test('should be a subclass of number trivia entitiy', () async {
      final result = tNumberTriviaModel.toEntity();
      expect(result, equals(tNumberTrivia));
    });
  });

  group('from Json', () {
    test('should return a valid model of json', () async {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(
        readJson('features/dummy_data.json'),
      );

      // act
      final result = NumberTriviaModel.fromJson(jsonMap);

      // assert
      expect(result, equals(tNumberTriviaModel));
    });
  });
}
