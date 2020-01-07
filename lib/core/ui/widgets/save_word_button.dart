import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocab/core/navigation/routes.dart';
import 'package:vocab/features/word_card/presentation/bloc/bloc.dart';

class SaveWordButton extends StatelessWidget {
  const SaveWordButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WordCardBloc, WordCardState>(
      builder: (BuildContext context, WordCardState state) {
        Function callBack;

        if (state is LoadedWordCardState) {
          callBack = () {
            Navigator.pushNamed(
              context,
              '${Page.CardFormPage}',
                arguments: {
                  'wordCard': state.wordCard,
                  'isEditing': false,
                },
            );
          };
        }

        return IconButton(
          color: Colors.white,
          disabledColor: Colors.grey[400],
          icon: Icon(Icons.save),
          onPressed: callBack,
        );
      },
    );
  }
}
