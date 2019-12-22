import 'package:equatable/equatable.dart';

import 'headword_entry.dart';

class RetrieveEntry extends Equatable {
  final Map<String, String> metaData;
  final String id, word;
  final List<HeadwordEntry> resultList;

  const RetrieveEntry({
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
