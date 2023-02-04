import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_flutter/blocs/words/words_bloc.dart';
import 'package:otp_flutter/components/custom_autocomplete.dart';
import 'package:otp_flutter/models/words_model.dart';
import 'package:otp_flutter/screens/scores_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerText = TextEditingController();

    return BlocListener<WordsBloc, WordsState>(
      listener: (context, WordsState state) {
        if (state is WordsLoaded) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Added successfully!')));
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAutocomplete(controller: controllerText),
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      var input = WordsModel(value: controllerText.value.text);
                      context.read<WordsBloc>().add(AddWord(words: input));
                      controllerText.clear();
                    },
                    child: const Text('Submit'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const ScoresScreen();
                      }));
                    },
                    child: const Text('Scores screen'))
                ],
              ),
            ),
            BlocBuilder<WordsBloc, WordsState>(
            builder: (context, state) {
              if (state is WordsLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is WordsLoaded) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: state.words.length,
                          itemBuilder: (context, index) {
                            return Text(state.words[index].value);
                          })
                    ],
                  ),
                );
              } else {
                return const Text('Something went wrong ...');
              }
            },
          )
          ]
        ),
      ),
    );
  }
}
