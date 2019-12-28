import 'package:vocab/features/query_word/data/models/base_info_model.dart';
import 'package:vocab/features/query_word/data/models/construction_model.dart';
import 'package:vocab/features/query_word/data/models/entry_model.dart';
import 'package:vocab/features/query_word/data/models/example_model.dart';
import 'package:vocab/features/query_word/data/models/lexical_entry_model.dart';
import 'package:vocab/features/query_word/data/models/pronunciation_model.dart';
import 'package:vocab/features/query_word/data/models/related_entry_model.dart';
import 'package:vocab/features/query_word/data/models/sense_model.dart';
import 'package:vocab/features/query_word/data/models/thesaurus_link_model.dart';
import 'package:vocab/features/query_word/data/models/variant_form_model.dart';

class ObjectConverter {
  static List<T> _toList<T>(data, converter) => List.from(data.map(converter));

  static List<BaseInfoModel> toBaseinfoList(data) {
    return data != null
        ? _toList<BaseInfoModel>(data, (e) => BaseInfoModel.fromJson(e))
        : [];
  }

  static List<EntryModel> toEntryList(data) {
    return data != null
        ? _toList<EntryModel>(data, (e) => EntryModel.fromJson(e))
        : [];
  }

  static List<RelatedEntryModel> toRelatedEntryList(data) {
    return data != null
        ? _toList<RelatedEntryModel>(data, (e) => RelatedEntryModel.fromJson(e))
        : [];
  }

  static List<PronunciationModel> toPronunciationList(data) {
    return data != null
        ? _toList<PronunciationModel>(
            data, (e) => PronunciationModel.fromJson(e))
        : [];
  }

  static List<VariantFormModel> toVariantFormList(data) {
    return data != null
        ? _toList<VariantFormModel>(data, (e) => VariantFormModel.fromJson(e))
        : [];
  }

  static List<SenseModel> toSenseList(data) {
    return data != null
        ? _toList<SenseModel>(data, (e) => SenseModel.fromJson(e))
        : [];
  }

  static List<LexicalEntryModel> toLexicalList(data) {
    return data != null
        ? _toList<LexicalEntryModel>(data, (e) => LexicalEntryModel.fromJson(e))
        : [];
  }

  static List<ConstructionModel> toConstructionList(data) {
    return data != null
        ? _toList<ConstructionModel>(data, (e) => ConstructionModel.fromJson(e))
        : [];
  }

  static List<ExampleModel> toExampleList(data) {
    return data != null
        ? _toList<ExampleModel>(data, (e) => ExampleModel.fromJson(e))
        : [];
  }

  static List<ThesaurusLinkModel> toThesaurusList(data) {
    return data != null
        ? _toList<ThesaurusLinkModel>(
            data,
            (e) => ThesaurusLinkModel.fromJson(e),
          )
        : [];
  }

  static List<String> toStringList(data) {
    return data != null ? List<String>.from(data) : [];
  }
}
