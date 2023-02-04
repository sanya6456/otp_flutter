part of 'words_bloc.dart';

class AddWord extends WordsEvent {
  final WordsModel words;

  const AddWord({required this.words});

  @override
  List<Object> get props => [words];
}

class RenderWords extends WordsEvent {
  final List<WordsModel> words;

  const RenderWords({this.words = const <WordsModel>[]});

  @override
  List<Object> get props => [words];
}

abstract class WordsEvent extends Equatable {
  const WordsEvent();

  @override
  List<Object> get props => [];
}
