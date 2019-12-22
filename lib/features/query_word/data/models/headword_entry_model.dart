import 'package:vocab/features/query_word/domain/entities/headword_entry.dart';

import 'pronunciation_model.dart';
import 'lexical_entry_model.dart';

/// [HeadwordEntryModel] class
///
/// Properties:
/// [id] (string): The identifier of a word ,
/// [language] (string): IANA language code ,
/// [lexicalEntryList] (List[LexicalEntryModel]): A grouping of various senses in a specific language,
/// and a lexical category that relates to a word ,
/// [pronunciationList] (List[PronunciationModel], optional),
/// [type] ([HeadwordType], optional): The json object type. Could be 'headword', 'inflection' or 'phrase',
/// [word] (string): (DEPRECATED) A given written or spoken realisation of an entry, lowercased.
class HeadwordEntryModel extends HeadwordEntry {
  HeadwordEntryModel({
    String id,
    String landauge,
    String word,
    HeadwordType type,
    List<LexicalEntryModel> lexicalEntryList,
    List<PronunciationModel> pronunciationList,
  }) : super(
          id: id,
          landauge: landauge,
          word: word,
          type: type,
          lexicalEntryList: lexicalEntryList,
          pronunciationList: pronunciationList,
        );

  @override
  List<Object> get props => [
        this.id,
        this.landauge,
        this.word,
        this.type,
        this.lexicalEntryList,
        this.pronunciationList,
      ];
}
