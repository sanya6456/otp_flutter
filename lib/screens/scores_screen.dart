import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_flutter/blocs/words/words_bloc.dart';
import 'package:otp_flutter/utils/sum_util.dart';

class ScoresScreen extends StatelessWidget {
const ScoresScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text('Screen 2')),
      body: BlocBuilder<WordsBloc, WordsState>(
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
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: SumUtil(arrayOfNumbers: state.words.map((item) => item.value.length)),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.words.length,
                      itemBuilder: (context, index) {
                        return Text(
                            '${state.words[index].value} - ${state.words[index].value.length}');
                      })
                ],
              ),
            );
          } else {
            return const Text('Somethong went wrong ...');
          }
        },
      ),
    );
  }
}