import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'alarm_model.g.dart';

@HiveType(typeId: 1)
class AlarmModel {
  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  TimeOfDay time;
  @HiveField(3)
  bool isEnable;
  @HiveField(4)
  bool isRadioactive;

  AlarmModel({
    String? id,
    this.title = 'Alarm',
    required this.time,
    required this.isEnable, 
    this.isRadioactive = false,
  })
      : id = id ?? DateTime.now().toIso8601String();

  factory AlarmModel.fromJson(Map<String, dynamic> json) {
    return AlarmModel(
      id: json['id'],
      title: json['title'],
      time: TimeOfDay(hour: json['time']['hour'], minute: json['time']['minute']),
      isEnable: json['isEnable'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'time': {
        'hour': time.hour,
        'minute': time.minute,
      },
      'isEnable': isEnable,
    };
  }

  @override
  String toString() {
    return 'AlarmModel{id: $id, title: $title, dateTime: $time, isEnable: $isEnable}';
  }
}