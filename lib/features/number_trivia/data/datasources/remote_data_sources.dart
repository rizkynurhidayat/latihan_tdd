import 'dart:convert';

import 'package:latihan_tdd/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:latihan_tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:http/http.dart' as http;

import '../../../../core/constant.dart';
import '../../../../core/exeption.dart';

abstract class RemoteDataSource {
  Future<NumberTriviaModel> getConcreateNumberTrivia(int number);
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class RemoteDataSourcesImpl implements RemoteDataSource {
  final http.Client client;
  RemoteDataSourcesImpl({required this.client});

  @override
  Future<NumberTriviaModel> getConcreateNumberTrivia(int number) async {
    // TODO: implement getCurrentNumberTrivia
    final response =
        await client.get(Uri.parse(Urls.concreateNumberTriviaByNumber(number)));

    if (response.statusCode == 200) {
      return NumberTriviaModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() async {
    // TODO: implement getRandomNumberTrivia
    final response =
        await client.get(Uri.parse(Urls.randomNumberTriviaByNumber()));

    if (response.statusCode == 200) {
      return NumberTriviaModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
