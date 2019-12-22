import 'package:equatable/equatable.dart';

/// [ThesaurusLink] class
/// entry_id (string): identifier of a word ,
/// sense_id (string): identifier of a sense
class ThesaurusLink extends Equatable {
  final String entryId, senseId;

  ThesaurusLink({this.entryId, this.senseId});

  @override
  List<Object> get props => [this.entryId, this.senseId];
}