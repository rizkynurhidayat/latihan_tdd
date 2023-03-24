import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latihan_tdd/features/number_trivia/presentation/bloc/NumberTrivia_bloc.dart';
import 'package:latihan_tdd/features/number_trivia/presentation/bloc/NumberTrivia_event.dart';
import 'package:latihan_tdd/features/number_trivia/presentation/bloc/NumberTrivia_state.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final numbeI = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Latihan TDD"),
      ),
      body: Center(
        child: SizedBox(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
              builder: (context, state) {
                if (state is NumberTriviaLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is NumberTriviaHasData) {
                  return ListTile(
                    key: const Key('Number_Trivia'),
                    title: Text('Your Number is ${state.result.number}'),
                    subtitle: Text(state.result.text),
                  );
                } else if (state is NumberTriviaError) {
                  return const Center(
                    child: Text('Something Wrong with You Bro !!!'),
                  );
                } else {
                  return const SizedBox(
                    width: 20,
                  );
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 300,
              child: TextField(
                textAlign: TextAlign.center,
                decoration: const InputDecoration(hintText: 'enter number'),
                controller: numbeI,
                onSubmitted: (value) {
                  context
                      .read<NumberTriviaBloc>()
                      .add(OnNumberChanged(int.parse(value)));
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      context.read<NumberTriviaBloc>().add(OnRandom());
                    },
                    child: const Text("Random")),
                ElevatedButton(
                    onPressed: () {
                      if (numbeI.text.isEmpty) {
                        context.read<NumberTriviaBloc>().add(OnRandom());
                      } else if (numbeI.text.isNotEmpty) {
                        context
                            .read<NumberTriviaBloc>()
                            .add(OnNumberChanged(int.parse(numbeI.text)));
                      }
                    },
                    child: const Text("Enter")),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
