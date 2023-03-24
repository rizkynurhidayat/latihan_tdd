import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:latihan_tdd/core/constant.dart';
import 'package:latihan_tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:latihan_tdd/features/number_trivia/presentation/bloc/NumberTrivia_bloc.dart';
import 'package:latihan_tdd/features/number_trivia/presentation/bloc/NumberTrivia_event.dart';
import 'package:latihan_tdd/features/number_trivia/presentation/bloc/NumberTrivia_state.dart';
import 'package:latihan_tdd/features/number_trivia/presentation/pages/number_trivia_page.dart';
import 'package:mocktail/mocktail.dart';

class MockNumberTriviaBloc
    extends MockBloc<NumberTriviaEvent, NumberTriviaState>
    implements NumberTriviaBloc {}

class FakeNumberTriviaState extends Fake implements NumberTriviaState {}

class FakeNumberTriviaEvent extends Fake implements NumberTriviaEvent {}

void main() {
  late MockNumberTriviaBloc mockNumberTriviaBloc;
  setUpAll(() async {
    HttpOverrides.global = null;
    registerFallbackValue(FakeNumberTriviaState());
    registerFallbackValue(FakeNumberTriviaEvent());

    final di = GetIt.instance;
    di.registerFactory(() => mockNumberTriviaBloc);
  });
  setUp(() {
    mockNumberTriviaBloc = MockNumberTriviaBloc();
  });
  final tNumberTrivia = NumberTrivia(text: 'test', number: 1);

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<NumberTriviaBloc>.value(
      value: mockNumberTriviaBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    'text field should trigger state to change from empty to loading',
    (WidgetTester tester) async {
      // arrange
      when(() => mockNumberTriviaBloc.state).thenReturn(NumberTriviaEmpty());

      // act
      await tester.pumpWidget(_makeTestableWidget(NumberTriviaPage()));
      await tester.enterText(find.byType(TextField), "42");
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      // assert
      verify(() => mockNumberTriviaBloc.add(OnNumberChanged(42))).called(1);
      expect(find.byType(TextField), equals(findsOneWidget));
    },
  );

  testWidgets(
    'should show progress indicator when state is loading',
    (WidgetTester tester) async {
      // arrange
      when(() => mockNumberTriviaBloc.state).thenReturn(NumberTriviaLoading());

      // act
      await tester.pumpWidget(_makeTestableWidget(NumberTriviaPage()));

      // assert
      expect(find.byType(CircularProgressIndicator), equals(findsOneWidget));
    },
  );

  testWidgets(
    'should show widget numbre trivia data when state is has data [concreate number]',
    (WidgetTester tester) async {
      // arrange
      when(() => mockNumberTriviaBloc.state)
          .thenReturn(NumberTriviaHasData(tNumberTrivia));

      // act
      await tester.pumpWidget(_makeTestableWidget(NumberTriviaPage()));
      await tester.runAsync(() async {
        final HttpClient client = HttpClient();
        await client.getUrl(Uri.parse(Urls.concreateNumberTriviaByNumber(42)));
      });
      await tester.pumpAndSettle();

      // assert
      expect(find.byKey(Key('Number_Trivia')), equals(findsOneWidget));
    },
  );

  testWidgets(
    'should show widget numbre trivia data when state is has data [random number]',
    (WidgetTester tester) async {
      // arrange
      when(() => mockNumberTriviaBloc.state)
          .thenReturn(NumberTriviaHasData(tNumberTrivia));

      // act
      await tester.pumpWidget(_makeTestableWidget(NumberTriviaPage()));
      await tester.runAsync(() async {
        final HttpClient client = HttpClient();
        await client.getUrl(Uri.parse(Urls.randomNumberTriviaByNumber()));
      });
      await tester.pumpAndSettle();

      // assert
      expect(find.byKey(Key('Number_Trivia')), equals(findsOneWidget));
    },
  );
}
