import 'package:equatable/equatable.dart';

import 'headword_entry_model.dart';

class RetrieveEntryModel extends Equatable {
  final Map<String, String> metaData;
  final String id, word;
  final List<HeadwordEntryModel> resultList;

  const RetrieveEntryModel({
    this.metaData,
    this.id,
    this.word,
    this.resultList,
  });

  @override
  List<Object> get props => [
        metaData,
        id,
        word,
        resultList,
      ];
}
