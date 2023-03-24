import 'package:http/http.dart' as http;
import 'package:latihan_tdd/features/number_trivia/data/datasources/remote_data_sources.dart';
import 'package:latihan_tdd/features/number_trivia/domain/repositories/number_trivia_repositories.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks(
  [
    NumberTriviaRepositories,
    RemoteDataSource,
  ],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)
void main() {}
