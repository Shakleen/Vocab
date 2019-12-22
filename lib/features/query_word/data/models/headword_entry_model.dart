import 'package:equatable/equatable.dart';

import 'pronunciation_model.dart';
import 'lexical_entry_model.dart';

enum HeadwordType { Headword, Inflection, Phrase }

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
class HeadwordEntryModel extends Equatable {
  final String id, landauge, word;
  final HeadwordType type;
  final List<LexicalEntryModel> lexicalEntryList;
  final List<PronunciationModel> pronunciationList;

  const HeadwordEntryModel({
    this.id,
    this.landauge,
    this.word,
    this.type,
    this.lexicalEntryList,
    this.pronunciationList,
  });

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
