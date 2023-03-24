import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:latihan_tdd/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:latihan_tdd/features/number_trivia/domain/repositories/number_trivia_repositories.dart';
import 'package:latihan_tdd/features/number_trivia/domain/usecases/get_random_number_trivia.dart';

import '../features/number_trivia/data/datasources/remote_data_sources.dart';
import '../features/number_trivia/domain/usecases/get_concreate_number_trivia.dart';
import '../features/number_trivia/presentation/bloc/NumberTrivia_bloc.dart';

final locator = GetIt.instance;

void init() {
  // bloc
  locator.registerFactory(() => NumberTriviaBloc(locator(), locator()));

  // usecase
  locator.registerLazySingleton(() => GetConcreateNumberTrivia(locator()));
  locator.registerLazySingleton(() => GetRandomNumberTrivia(locator()));

  // repository
  locator.registerLazySingleton<NumberTriviaRepositories>(
    () => NumberTriviaRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );

  // data source
  locator.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourcesImpl(
      client: locator(),
    ),
  );

  // external
  locator.registerLazySingleton(() => http.Client());
}
