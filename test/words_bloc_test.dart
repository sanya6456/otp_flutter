import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:otp_flutter/blocs/words/words_bloc.dart';
import 'package:otp_flutter/models/words_model.dart';

void main() {
  group('WordsBloc test', () {
    final wordsBloc = WordsBloc();

    test('Initial state', () {
      expect(wordsBloc.state, WordsLoading());
    });

    // Not working ..
    blocTest('Add a word',
      build: () => wordsBloc,
      act: (bloc) => bloc.add(const AddWord(words: WordsModel(value: 'abcd'))),
      expect: () => const <WordsState>[WordsLoaded(words: [WordsModel(value: 'abcd')])]
    );
  });
}
