import 'package:hive/hive.dart';

part 'alarm_model.g.dart';

@HiveType(typeId: 1)
class AlarmModel {
  @HiveField(0)
  int id;
  @HiveField(1)
  String title;
  @HiveField(2)
  DateTime dateTime;
  @HiveField(3)
  bool isEnable;
  @HiveField(4)
  bool isRadioactive;

  AlarmModel({
    int? id,
    required this.title,
    required this.dateTime,
    required this.isEnable, 
    this.isRadioactive = false,
  })
      : id = id ?? dateTime.millisecondsSinceEpoch;

  factory AlarmModel.fromJson(Map<String, dynamic> json) {
    return AlarmModel(
      id: json['id'],
      title: json['title'],
      dateTime: DateTime.parse(json['dateTime']),
      isEnable: json['isEnable'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'dateTime': dateTime.toIso8601String(),
      'isEnable': isEnable,
    };
  }

  @override
  String toString() {
    return 'AlarmModel{id: $id, title: $title, dateTime: $dateTime, isEnable: $isEnable}';
  }
}
