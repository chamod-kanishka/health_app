import 'package:flutter/material.dart';
import 'screens/health_home_screen.dart';

void main() {
  runApp(HealthApp());
}

class HealthApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HealthHomeScreen(),
    );
  }
}
