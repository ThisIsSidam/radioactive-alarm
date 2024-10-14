import 'package:flutter/material.dart';
import 'package:radioactive_alarm/database/alarms_db.dart';
import 'package:radioactive_alarm/models/alarm_model/alarm_model.dart';
import 'package:radioactive_alarm/screens/home_screen/widgets/alarm_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alarms'),
      ),
      body: _buildAlarmsList(),
      bottomSheet: _buildAddAlarmButtonSheet(context),
    );
  }

  Widget _buildAlarmsList() {
    List<AlarmModel> alarms = AlarmsDB.getAlarms();

    return Column(
      children: [
        for (final AlarmModel alarm in alarms) ...<Widget>[
          AlarmCard(alarm: alarm),
        ]
      ]
    );
  }

  Widget _buildAddAlarmButtonSheet(BuildContext context) {
    return BottomSheet(
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      onClosing: () {},
      builder: (context,) {
        return Container(
          width: double.infinity,
          height: 48,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20)
            )
          ),
          child: TextButton(
            onPressed: () async {
              final TimeOfDay? timeOfDay = await showDialog<TimeOfDay>(
                context: context,
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: TimePickerDialog(initialTime: TimeOfDay.now()),
                  );
                }
              );

              if (timeOfDay == null) {
                return;
              } 

              final AlarmModel alarm = AlarmModel(
                isEnable: true,
                time: timeOfDay,
              );
              setState(() {
                AlarmsDB.addAlarm(alarm);
              });
            },
            child: const Icon(
              Icons.add,
              size: 40,
            ),
          ),
        );
      }
    );
  }
}