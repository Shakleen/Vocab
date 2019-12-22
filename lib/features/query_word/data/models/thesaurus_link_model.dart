import 'package:equatable/equatable.dart';

/// [ThesaurusLinkModel] class
/// entry_id (string): identifier of a word ,
/// sense_id (string): identifier of a sense
class ThesaurusLinkModel extends Equatable {
  final String entryId, senseId;

  ThesaurusLinkModel({this.entryId, this.senseId});

  @override
  List<Object> get props => [this.entryId, this.senseId];
}