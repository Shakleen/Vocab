import 'package:vocab/features/query_word/domain/entities/thesaurus_link.dart';

/// [ThesaurusLinkModel] class
/// entry_id (string): identifier of a word ,
/// sense_id (string): identifier of a sense
class ThesaurusLinkModel extends ThesaurusLink {
  ThesaurusLinkModel({String entryId, String senseId})
      : super(entryId: entryId, senseId: senseId);

  factory ThesaurusLinkModel.fromJson(Map<String, dynamic> json) =>
      ThesaurusLinkModel(entryId: json['entry_id'], senseId: json['sense_id']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};

    json['entry_id'] = entryId;
    json['sense_id'] = senseId;

    return json;
  }
}
