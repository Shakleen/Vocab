import 'package:equatable/equatable.dart';

import 'base_info_model.dart';

class ConstructionModel extends Equatable {
  final List<BaseInfoModel> domainList;
  final List<String> exampleList;
  final List<BaseInfoModel> noteList;
  final List<BaseInfoModel> regionList;
  final List<BaseInfoModel> registerList;
  final String text;

  ConstructionModel({
    this.domainList,
    this.exampleList,
    this.noteList,
    this.regionList,
    this.registerList,
    this.text,
  });

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