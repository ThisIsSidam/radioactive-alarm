import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:radioactive_alarm/app.dart';
import 'package:radioactive_alarm/consts/strings.dart';
import 'package:radioactive_alarm/models/alarm_model/alarm_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.openBox(HiveBox.alarmsDB.name);
  Hive.registerAdapter(AlarmModelAdapter());

  runApp(const MyApp());
}