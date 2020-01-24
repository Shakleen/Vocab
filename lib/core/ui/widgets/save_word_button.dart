import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocab/core/entities/pronunciation.dart';
import 'package:vocab/core/entities/word_card.dart';
import 'package:vocab/core/navigation/routes.dart';
import 'package:vocab/features/query_word/presentation/bloc/bloc.dart';
import 'package:vocab/features/word_card/presentation/bloc/bloc.dart';

class SaveWordButton extends StatelessWidget {
  const SaveWordButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WordCardBloc, WordCardState>(
      builder: (BuildContext context, WordCardState stateW) {
        return BlocBuilder<QueryWordBloc, QueryWordState>(
          builder: (BuildContext context, QueryWordState stateQ) {
            Function callBack;
            String audioUrl;

            if (stateQ is LoadedQueryWordState) {
              audioUrl = stateQ.retrieveEntry.resultList[0].lexicalEntryList[0]
                  .pronunciationList[0].audioFileUrl;
            }

            if (stateW is LoadedWordCardState) {
              callBack = () {
                Navigator.pushNamed(
                  context,
                  '${Page.CardFormPage}',
                  arguments: {
                    'wordCard': WordCard(
                      detailList: stateW.wordCard.detailList,
                      pronunciation: audioUrl,
                      syllables: stateW.wordCard.syllables,
                      word: stateW.wordCard.word,
                    ),
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
      },
    );
  }
}
