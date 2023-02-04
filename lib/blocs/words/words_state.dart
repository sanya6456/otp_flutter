part of 'words_bloc.dart';

class WordsLoaded extends WordsState {
  @override
  final List<WordsModel> words;

  const WordsLoaded({this.words = const <WordsModel>[]});

  @override
  List<Object> get props => [words];
}

class WordsLoading extends WordsState {}

@immutable
abstract class WordsState extends Equatable {
  const WordsState();
  
  @override
  List<Object> get props => [];

  get words => null;
}
