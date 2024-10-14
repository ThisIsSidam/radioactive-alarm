import 'package:flutter/material.dart';
import 'package:radioactive_alarm/database/alarms_db.dart';
import 'package:radioactive_alarm/models/alarm_model/alarm_model.dart';

class AlarmScreen extends StatelessWidget {
  const AlarmScreen({
    super.key, 
    required this.alarmId
  });

  final int alarmId;

  @override
  Widget build(BuildContext context) {
    final AlarmModel alarm = AlarmsDB.getAlarm(alarmId);

    final hour = alarm.time.hour;
    final minute = alarm.time.minute;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$hour:$minute',
              style: TextStyle(
                fontSize: 80,
                fontWeight: alarm.isEnabled ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            IconButton(
              onPressed: () {
                final alarm = AlarmsDB.getAlarm(alarmId);
                alarm.isEnabled = !alarm.isEnabled;
                AlarmsDB.addAlarm(alarm);
                Navigator.pop(context);
              },
              icon: const Icon(Icons.alarm_on)
            )
          ],
        )
      )
    );
  }
}