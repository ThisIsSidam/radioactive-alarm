import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:radioactive_alarm/models/alarm_model/alarm_model.dart';

class AlarmCard extends StatelessWidget {
  final AlarmModel alarm;

  const AlarmCard({super.key, required this.alarm});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: Text(
          alarm.title
        ),
        children: const [
          ListTile(
            leading: Icon(Icons.library_music),
            title: Text('Coming Soon')
          ),
          ListTile(
            leading: Icon(Icons.delete),
            title: Text('Delete'),
          ),
        ],
      ),
    );
  }

  
  Widget _buildTimeSection() {
    final hour = DateFormat('hh').format(alarm.dateTime);
    final minute = DateFormat('mm').format(alarm.dateTime);
    final isAm = DateFormat('a').format(alarm.dateTime) == 'AM';

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$hour:$minute',
            style: TextStyle(
              fontSize: 40,
              fontWeight: alarm.isEnable ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          TextSpan(
            text: ' ${isAm ? 'am' : 'pm'}',
            style: TextStyle(
              fontSize: 8,
              fontWeight: alarm.isEnable ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
