import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:latihan_tdd/core/constant.dart';
import 'package:latihan_tdd/core/exeption.dart';
import 'package:latihan_tdd/features/number_trivia/data/datasources/remote_data_sources.dart';
import 'package:latihan_tdd/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import '../../../core/json_reader.dart';
import '../../../core/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late RemoteDataSourcesImpl dataSources;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSources = RemoteDataSourcesImpl(client: mockHttpClient);
  });

  group('get current Number Trivia', () {
    final tNumber = 1;
    final tNumberTriviaModel = NumberTriviaModel.fromJson(
        json.decode(readJson("features/dummy_data.json")));

    test('should return number trivia model when response 200', () async {
      //arrange
      when(
        mockHttpClient
            .get(Uri.parse(Urls.concreateNumberTriviaByNumber(tNumber))),
      ).thenAnswer((_) async =>
          http.Response(readJson('features/dummy_data.json'), 200));
      //arc
      final result = await dataSources.getConcreateNumberTrivia(tNumber);
      //assert
      expect(result, equals(tNumberTriviaModel));
    });

    test(
      'should throw a server exception when the response code is 404 or other',
      () async {
        // arrange
        when(
          mockHttpClient
              .get(Uri.parse(Urls.concreateNumberTriviaByNumber(tNumber))),
        ).thenAnswer(
          (_) async => http.Response('Not found', 404),
        );

        // act
        final call = dataSources.getConcreateNumberTrivia(tNumber);

        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });
}
