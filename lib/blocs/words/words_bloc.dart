import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_flutter/models/words_model.dart';

part 'words_event.dart';
part 'words_state.dart';

class WordsBloc extends Bloc<WordsEvent, WordsState> {
  WordsBloc() : super(WordsLoading()) {
    on<RenderWords>(_onLoadList);
    on<AddWord>(_onAddWords);
  }

  void _onAddWords(AddWord event, Emitter<WordsState> emit) {
    final state = this.state;
    if (state is WordsLoaded) {
      emit(WordsLoaded(words: List.from(state.words)..add(event.words)));
    }
  }

  void _onLoadList(event, emit) {
    emit(WordsLoaded(words: event.words));
  }
}
