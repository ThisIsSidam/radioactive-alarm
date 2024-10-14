import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:radioactive_alarm/models/alarm_model/utils/id_generator.dart';

part 'alarm_model.g.dart';

@HiveType(typeId: 1)
class AlarmModel {
  @HiveField(0)
  int id;
  @HiveField(1)
  String title;
  @HiveField(2)
  TimeOfDay time;
  @HiveField(3)
  bool isEnabled;
  @HiveField(4)
  bool isRadioactive;

  AlarmModel({
    int? id,
    this.title = 'Alarm',
    required this.time,
    required this.isEnabled, 
    this.isRadioactive = false,
  })
      : id = id ?? generateUniqueIntId();

  factory AlarmModel.fromJson(Map<String, dynamic> json) {
    return AlarmModel(
      id: json['id'],
      title: json['title'],
      time: TimeOfDay(hour: json['time']['hour'], minute: json['time']['minute']),
      isEnabled: json['isEnable'],
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
      'isEnable': isEnabled,
    };
  }

  @override
  String toString() {
    return 'AlarmModel{id: $id, title: $title, dateTime: $time, isEnable: $isEnabled}';
  }

  DateTime getNextAlarmDateTime() {
    final now = DateTime.now();
    return DateTime(
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
      0, 
      0,
      0,
    );
  }
}