import 'package:flutter/material.dart';
import 'package:radioactive_alarm/database/alarms_db.dart';
import 'package:radioactive_alarm/models/alarm_model/alarm_model.dart';

class AlarmCard extends StatefulWidget {
  final AlarmModel alarm;

  const AlarmCard({super.key, required this.alarm});

  @override
  State<AlarmCard> createState() => _AlarmCardState();
}

class _AlarmCardState extends State<AlarmCard> {

  final ExpansionTileController _controller = ExpansionTileController();

  // This changes when _controller.isExpanded changes
  // Using a separate one because we have access this even before 
  // _controller is assigned to an expansion tile and it doesn't 
  // take a default value.
  bool isExpanded = false;

  void _toggleExpansion() {
    if (_controller.isExpanded) {
      _controller.collapse();
      isExpanded = false;
    } else {
      _controller.expand();
      isExpanded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(25)
        ),
        child: Column(
          children: [
            _buildLabelListTile(context),
            ExpansionTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25)
              ),
              controller: _controller,
              title: _buildTimeSection(),
              subtitle: _buildSubtitle(),
              showTrailingIcon: false,
              onExpansionChanged: (value) {
                setState(() {
                  isExpanded = value;
                });
              },
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
          ],
        ),
      ),
    );
  }

  Widget _buildLabelListTile(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isExpanded
          ? Flexible(
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              minTileHeight: 18,
              leading: isExpanded 
              ? const Icon(Icons.label_outline)
              : null,
              title: isExpanded
              ? const Text('label')
              : const SizedBox.shrink(),
            ),
          )
          : const Spacer(),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: isExpanded 
              ? const EdgeInsets.only(
                top: 8, right: 16,
              )
              : const EdgeInsets.only(
                top: 8, right: 16
              ),
              child: SizedBox(
                  width: 18,
                  height: 18,
                  child: IconButton.filled(
                    padding: EdgeInsets.zero,
                    style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.grey),
                    ),
                    onPressed: _toggleExpansion, 
                    icon: Icon(
                      isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                      size: 16,
                    )
                  ),
                ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeSection() {
    final hour = widget.alarm.time.hour;
    final minute = widget.alarm.time.minute;
    final isAm = hour < 12;

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}',
            style: TextStyle(
              fontSize: 40,
              fontWeight: widget.alarm.isEnable ? FontWeight.bold : FontWeight.w300,
            ),
          ),
          TextSpan(
            text: ' ${isAm ? 'am' : 'pm'}',
            style: TextStyle(
              fontSize: 12,
              fontWeight: widget.alarm.isEnable ? FontWeight.bold : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubtitle() {
    return Row(
      children: [
        const Text(
          'Repeat (Coming Soon)'
        ),
        const Spacer(),
        Switch(
          value: widget.alarm.isEnable,
          onChanged: (val) {
            widget.alarm.isEnable = val;
            setState(() {
              AlarmsDB.addAlarm(widget.alarm);
            });
          },
        )
      ],
    );
  }
}
