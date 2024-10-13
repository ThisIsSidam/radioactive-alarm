import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:radioactive_alarm/screens/homescreen/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {

        ColorScheme lightColorScheme;
        ColorScheme darkColorScheme;

        if (lightDynamic != null && darkDynamic != null) {
          lightColorScheme = lightDynamic.harmonized();
          darkColorScheme = darkDynamic.harmonized();
        } else {
          lightColorScheme = ColorScheme.fromSwatch(primarySwatch: Colors.blue);
          darkColorScheme = ColorScheme.fromSwatch(brightness: Brightness.dark);
        }

        return MaterialApp(
          home: const HomeScreen(),
          themeMode: ThemeMode.system,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: lightColorScheme
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: darkColorScheme
          ),
        );

      }
    );
  }
}