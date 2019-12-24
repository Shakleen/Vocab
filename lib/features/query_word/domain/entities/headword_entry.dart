import 'package:equatable/equatable.dart';

import 'pronunciation.dart';
import 'lexical_entry.dart';

enum HeadwordType { Headword, Inflection, Phrase }

/// [HeadwordEntry] class
///
/// Properties:
/// [id] (string): The identifier of a word ,
/// [language] (string): IANA language code ,
/// [lexicalEntryList] (List[LexicalEntry]): A grouping of various senses in a specific language,
/// and a lexical category that relates to a word ,
/// [pronunciationList] (List[Pronunciation], optional),
/// [type] ([HeadwordType], optional): The json object type. Could be 'headword', 'inflection' or 'phrase',
/// [word] (string): (DEPRECATED) A given written or spoken realisation of an entry, lowercased.
class HeadwordEntry extends Equatable {
  final String id, language, word;
  final HeadwordType type;
  final List<LexicalEntry> lexicalEntryList;
  final List<Pronunciation> pronunciationList;

  const HeadwordEntry({
    this.id,
    this.language,
    this.word,
    this.type,
    this.lexicalEntryList,
    this.pronunciationList,
  });

  @override
  List<Object> get props => [
        this.id,
        this.language,
        this.word,
        this.type,
        this.lexicalEntryList,
        this.pronunciationList,
      ];
}
