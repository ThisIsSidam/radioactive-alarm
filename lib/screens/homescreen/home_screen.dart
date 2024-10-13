import 'package:flutter/material.dart';
import 'package:radioactive_alarm/database/alarms_db.dart';
import 'package:radioactive_alarm/models/alarm_model/alarm_model.dart';
import 'package:radioactive_alarm/screens/homescreen/widgets/alarm_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: _buildAlarmsList(),
      bottomSheet: _buildAddAlarmButtonSheet(),
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

  
  Widget _buildAddAlarmButtonSheet() {
    return BottomSheet(
      onClosing: () {},
      builder: (context,) {
        return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20)
            )
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                // TODO: Implement on tap
              },
              child: const Icon(
                Icons.add,
                size: 40,
              ),
            ),
          ),
        );
      }
    );
  }
}