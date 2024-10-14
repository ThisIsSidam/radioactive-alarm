import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:radioactive_alarm/consts/strings.dart';
import 'package:radioactive_alarm/models/alarm_model/alarm_model.dart';

class AlarmsDB {
  static final _box = Hive.box(HiveBox.alarmsDB.name);

  static List<AlarmModel> getAlarms() {
    final Iterable<dynamic> alarmsRaw = _box.values;
    return alarmsRaw.cast<AlarmModel>().toList();
  } 

  static AlarmModel getAlarm(int id) {
    return _box.get(id);
  }

  static void addAlarm(AlarmModel alarm) {
    _box.put(alarm.id, alarm);
  }
  
  static void deleteAlarm(int id) {
    if (_box.containsKey(id)) {
      _box.delete(id);
    } else {
      if (kDebugMode) debugPrint('[deleteAlarm] deleted alarm $id');
    }
  }
}