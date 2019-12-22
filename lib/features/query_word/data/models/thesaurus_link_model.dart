import 'package:equatable/equatable.dart';
import 'package:vocab/features/query_word/domain/entities/thesaurus_link.dart';

/// [ThesaurusLinkModel] class
/// entry_id (string): identifier of a word ,
/// sense_id (string): identifier of a sense
class ThesaurusLinkModel extends ThesaurusLink {
  ThesaurusLinkModel({String entryId, String senseId})
      : super(entryId: entryId, senseId: senseId);

  @override
  List<Object> get props => [this.entryId, this.senseId];
}
