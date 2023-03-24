import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latihan_tdd/features/number_trivia/presentation/bloc/NumberTrivia_bloc.dart';
import 'package:latihan_tdd/features/number_trivia/presentation/pages/number_trivia_page.dart';
import 'core/injection.dart' as di;

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => di.locator<NumberTriviaBloc>(),
          )
        ],
        child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
                colorScheme: ColorScheme.light(
                    primary: Colors.amber, secondary: Colors.cyan),
                useMaterial3: true),
            home: const NumberTriviaPage()));
  }
}
