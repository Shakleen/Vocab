import 'package:equatable/equatable.dart';

import 'base_info.dart';

class Construction extends Equatable {
  final List<BaseInfo> domainList;
  final List<String> exampleList;
  final List<BaseInfo> noteList;
  final List<BaseInfo> regionList;
  final List<BaseInfo> registerList;
  final String text;

  Construction({
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