import 'dart:async';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:radioactive_alarm/models/alarm_model/alarm_model.dart';

class AlarmHandler {

  static Future<void> init() async {
    await AndroidAlarmManager.initialize();
  }

  static Future<bool> scheduleAlarm(
    AlarmModel alarm,
  ) async {

    final time = alarm.getNextAlarmDateTime();
    if (kDebugMode) debugPrint('[scheduleAlarm] $time');

    await AndroidAlarmManager.oneShotAt(
      time,
      alarm.id,
      showNotificationCallback,
      alarmClock: true,
      allowWhileIdle: true,
      exact: true,
      wakeup: true,
      rescheduleOnReboot: true,
    );

    return true;
  }

  @pragma('vm:entry-point')
  static void showNotificationCallback() {
    debugPrint("showNotificationCallback");
  }

  /// Cancels the scheduled notification. 
  static Future<void> cancelScheduledAlarm(int id) async {
    await AndroidAlarmManager.cancel(id);
    debugPrint("$id cancelled scheduled notification.");
  }

}
