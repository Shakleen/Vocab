import 'package:equatable/equatable.dart';
import 'package:vocab/features/query_word/domain/entities/construction.dart';

import 'base_info_model.dart';

class ConstructionModel extends Construction {
  ConstructionModel({
    List<BaseInfoModel> domainList,
    List<String> exampleList,
    List<BaseInfoModel> noteList,
    List<BaseInfoModel> regionList,
    List<BaseInfoModel> registerList,
    String text,
  }) : super(
          domainList: domainList,
          exampleList: exampleList,
          noteList: noteList,
          regionList: regionList,
          registerList: registerList,
          text: text,
        );

  @override
  List<Object> get props => [
        domainList,
        exampleList,
        noteList,
        regionList,
        registerList,
        text,
      ];
}
