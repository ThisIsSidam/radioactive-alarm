import 'package:flutter/material.dart';

class CustomTimePicker extends StatefulWidget {
  final TimeOfDay initialTime;

  const CustomTimePicker({super.key, required this.initialTime});

  @override
  _CustomTimePickerState createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  late TimeOfDay _selectedTime;
  late bool _isAM;

  @override
  void initState() {
    super.initState();
    _selectedTime = widget.initialTime;
    _isAM = _selectedTime.period == DayPeriod.am;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[900],
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTimeField(
                value: _selectedTime.hourOfPeriod.toString().padLeft(2, '0'),
                onTap: () {
                  // Implement hour selection logic
                },
              ),
              const Text(':', style: TextStyle(color: Colors.white, fontSize: 36)),
              _buildTimeField(
                value: _selectedTime.minute.toString().padLeft(2, '0'),
                onTap: () {
                  // Implement minute selection logic
                },
              ),
              _buildAMPMToggle(),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 250,
            height: 250,
            child: TimePickerDialog(
              initialTime: widget.initialTime,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: const Text('Cancel', style: TextStyle(color: Colors.white)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: const Text('OK', style: TextStyle(color: Colors.white)),
          onPressed: () => Navigator.of(context).pop(_selectedTime),
        ),
      ],
    );
  }

  Widget _buildTimeField({required String value, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          value,
          style: const TextStyle(color: Colors.white, fontSize: 36),
        ),
      ),
    );
  }

  Widget _buildAMPMToggle() {
    return Column(
      children: [
        _buildAMPMButton('AM', _isAM),
        const SizedBox(height: 4),
        _buildAMPMButton('PM', !_isAM),
      ],
    );
  }

  Widget _buildAMPMButton(String text, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isAM = text == 'AM';
          _selectedTime = TimeOfDay(
            hour: _selectedTime.hour % 12 + (_isAM ? 0 : 12),
            minute: _selectedTime.minute,
          );
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

