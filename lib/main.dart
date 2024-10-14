import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:radioactive_alarm/app.dart';
import 'package:radioactive_alarm/consts/strings.dart';
import 'package:radioactive_alarm/models/alarm_model/alarm_model.dart';
import 'package:radioactive_alarm/models/time_of_day/time_of_day.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(AlarmModelAdapter());
  Hive.registerAdapter(TimeOfDayAdapter());
  await Hive.openBox(HiveBox.alarmsDB.name);

  runApp(const MyApp());
}