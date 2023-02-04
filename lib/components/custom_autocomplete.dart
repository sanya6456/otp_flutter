import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_flutter/blocs/words/words_bloc.dart';
import 'package:otp_flutter/models/words_model.dart';

class CustomAutocomplete extends StatefulWidget {
  final TextEditingController controller;

  const CustomAutocomplete(
      {Key? key, required this.controller})
      : super(key: key);

  @override
  _CustomAutocompleteState createState() => _CustomAutocompleteState();
}

class _CustomAutocompleteState extends State<CustomAutocomplete> {
  @override
  Widget build(BuildContext context) {
    final FocusNode focusNode = FocusNode();
    final GlobalKey autocompleteKey = GlobalKey();

    return BlocBuilder<WordsBloc, WordsState>(
      builder: (context, state) {
        return RawAutocomplete<WordsModel>(
            key: autocompleteKey,
            displayStringForOption: _displayStringForOption,
            textEditingController: widget.controller,
            focusNode: focusNode,
            optionsBuilder: (TextEditingValue controllerText) {
              if (state is WordsLoaded) {
                return state.words.where((option) => option.value
                    .toLowerCase()
                    .contains(controllerText.text.toLowerCase()));
              } else {
                return const Iterable.empty();
              }
            },
            fieldViewBuilder:
                (context, textEditingController, focusNode, onFieldSubmitted) {
              return TextField(
                  onEditingComplete: onFieldSubmitted,
                  controller: textEditingController,
                  focusNode: focusNode,
                  maxLength: 45,
                  decoration: const InputDecoration(
                    hintText: 'Write here ...',
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]"))
                  ],
                  keyboardType: TextInputType.text);
            },
            optionsViewBuilder: (BuildContext context,
                AutocompleteOnSelected<WordsModel> onSelected,
                Iterable<WordsModel> options) {
              return Align(
                alignment: Alignment.topLeft,
                child: Material(
                  child: Container(
                    height: 300,
                    color: Colors.blue,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(10.0),
                      itemCount: options.length,
                      itemBuilder: (BuildContext context, int index) {
                        final option = options.elementAt(index);

                        return GestureDetector(
                          onTap: () {
                            onSelected(option);
                          },
                          child: ListTile(
                            title: Text(option.value,
                                style: const TextStyle(color: Colors.white)),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            });
      },
    );
  }

  static String _displayStringForOption(WordsModel option) => option.value;
}
