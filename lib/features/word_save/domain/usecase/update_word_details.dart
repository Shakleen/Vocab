import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:vocab/core/entities/pronunciation.dart';
import 'package:vocab/core/entities/syllable.dart';
import 'package:vocab/core/entities/word_card.dart';
import 'package:vocab/core/entities/word_card_details.dart';
import 'package:vocab/core/enums/part_of_speech.dart';
import 'package:vocab/core/error/failures.dart';
import 'package:vocab/core/usecases/usecase.dart';
import 'package:vocab/features/word_save/domain/entity/word_details_keys.dart';
import 'package:vocab/features/word_save/domain/repository/word_save_repository.dart';

const String SEPERATOR = ' | ';

class UpdateWordDetails extends UseCase<bool, Param> {
  final WordSaveRepository repository;

  UpdateWordDetails({@required this.repository});

  @override
  Future<Either<Failure, bool>> call(Param params) async {
    final WordCard wordCard = _parse(params);

    final attemptInsertion = await repository.updateWordDetails(wordCard);
    return attemptInsertion.fold(
      (Failure l) => Left(l),
      (bool r) {
        // if (r) {
        //   for (int i = 0; i < wordCard.detailList.length; ++i) {
        //     if (wordCard.detailList[i].exampleList.isNotEmpty && params.previous.detailList[i].exampleList.isEmpty) {

        //     }
        //   }
        // }
        return Right(r);
      },
    );
  }

  WordCard _parse(Param params) {
    final List<String> syllables = params
        .wordDetails[getWordDetailKeyString(WordDetailKeys.syllables)]
        .split(SEPERATOR);

    final List<WordCardDetails> detailList = [];

    params.wordDetails[getWordDetailKeyString(WordDetailKeys.senses)].forEach(
      (Map<String, dynamic> value) => WordCardDetails(
        id: value[getWordDetailKeyString(WordDetailKeys.senseID)],
        definition: value[getWordDetailKeyString(WordDetailKeys.definition)],
        partOfSpeech: ID_TO_PART_OF_SPEECH_TYPE[
            value[getWordDetailKeyString(WordDetailKeys.partOfSpeech)]],
        antonymList: value[getWordDetailKeyString(WordDetailKeys.antonyms)]
            ?.split(SEPERATOR),
        synonymList: value[getWordDetailKeyString(WordDetailKeys.synonyms)]
            ?.split(SEPERATOR),
        exampleList: value[getWordDetailKeyString(WordDetailKeys.examples)]
            ?.split(SEPERATOR),
      ),
    );

    return WordCard(
      id: params.wordDetails[getWordDetailKeyString(WordDetailKeys.id)],
      word: params.wordDetails[getWordDetailKeyString(WordDetailKeys.word)],
      syllables: syllables,
      detailList: detailList,
      pronunciation: params
          .wordDetails[getWordDetailKeyString(WordDetailKeys.pronunciation)],
    );
  }
}

class Param extends Equatable {
  final WordCard previous;
  final Map<String, dynamic> wordDetails;

  const Param({@required this.wordDetails, @required this.previous});

  @override
  List<Object> get props => [wordDetails];
}
