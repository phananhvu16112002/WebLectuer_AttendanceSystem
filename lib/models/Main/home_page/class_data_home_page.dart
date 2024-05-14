import 'package:weblectuer_attendancesystem_nodejs/models/Main/Class.dart';

class ClassDataHomePage {
  int? totalPage;
  List<Class>? classes;

  ClassDataHomePage({
    this.totalPage,
    this.classes,
  });

  factory ClassDataHomePage.fromJson(Map<String, dynamic> map) {
    return ClassDataHomePage(
      totalPage: map['totalPage'] as int?,
      classes: (map['classes'] as List<dynamic>)
          .map((x) => Class.fromJson(x as Map<String, dynamic>))
          .toList(),
    );
  }
}
