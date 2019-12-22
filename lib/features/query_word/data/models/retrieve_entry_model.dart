import 'package:vocab/features/query_word/domain/entities/retrieve_entry.dart';

import 'headword_entry_model.dart';

class RetrieveEntryModel extends RetrieveEntry {
  RetrieveEntryModel({
    Map<String, String> metaData,
    String id,
    String word,
    List<HeadwordEntryModel> resultList,
  }) : super(
          metaData: metaData,
          id: id,
          word: word,
          resultList: resultList,
        );
}
