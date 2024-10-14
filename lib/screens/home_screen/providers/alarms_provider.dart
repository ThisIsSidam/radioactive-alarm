import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:radioactive_alarm/alarm_system/alarm_hander.dart';
import 'package:radioactive_alarm/database/alarms_db.dart';
import 'package:radioactive_alarm/models/alarm_model/alarm_model.dart';

class AlarmsNotifier extends ChangeNotifier {
  List<AlarmModel> alarms = AlarmsDB.getAlarms();
  
  void addAlarm(AlarmModel alarm) {
    AlarmsDB.addAlarm(alarm);
    alarms = AlarmsDB.getAlarms();
    AlarmHandler.scheduleAlarm(alarm);
    notifyListeners();
  }

  void deleteAlarm(int id) {
    AlarmsDB.deleteAlarm(id);
    alarms = AlarmsDB.getAlarms();
    AlarmHandler.cancelScheduledAlarm(id);
    notifyListeners();
  }

}   

final alarmsProvider = ChangeNotifierProvider<AlarmsNotifier>(
  (ref) => AlarmsNotifier()
);

