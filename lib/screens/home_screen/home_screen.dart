import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:radioactive_alarm/models/alarm_model/alarm_model.dart';
import 'package:radioactive_alarm/screens/home_screen/providers/alarms_provider.dart';
import 'package:radioactive_alarm/screens/home_screen/widgets/alarm_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
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
    List<AlarmModel> alarms = ref.watch(alarmsProvider).alarms;

    // No alarms -> show Empty Screen
    if (alarms.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.alarm,
              size: 120,
            ),
            Text(
              'No Alarms Present'
            )
          ],
        )
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          for (final AlarmModel alarm in alarms) ...<Widget>[
            AlarmCard(alarm: alarm),
          ],
          const SizedBox(height: 64),
        ]
      ),
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
                isEnabled: true,
                time: timeOfDay,
              );
              ref.read(alarmsProvider).addAlarm(alarm);
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