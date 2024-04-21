// import 'package:audioplayers/audioplayers.dart';
import 'package:beep_player/beep_player.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'health_data_display.dart';
import 'health_chart.dart';

class HealthMonitor extends StatefulWidget {
  @override
  _HealthMonitorState createState() => _HealthMonitorState();
}

class _HealthMonitorState extends State<HealthMonitor> {
  late Timer timer;
  List<double> data = [0];
  double lastGeneratedValue = 0;
  bool isGenerating = false;

  // late AudioPlayer player; // Remove initialization here
  static const BeepFile _beepFile = BeepFile('assets/beep.wav');


  @override
  void dispose() {
    timer.cancel();
    // player.dispose(); // Dispose the player when the state is disposed
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // player = AudioPlayer(); // Initialize the player here
    BeepPlayer.load(_beepFile);

  }

  void startGenerating() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      generateRandomValues();
    });
  }

  void generateRandomValues() {
    Random random = Random();
    double value = random.nextDouble() * 100;

    setState(() {
      if (data.length >= 16) {
        data.removeAt(0);
      }
      data.add(value);
      lastGeneratedValue = value;
    });

    playBeep(lastGeneratedValue); // Call playBeep here
  }

  String getHeartStatus(double value) {
    if (value < 50) {
      return "Resting";
    } else if (value < 80) {
      return "Normal";
    } else {
      return "High";
    }
  }

  Color getHeartColor(double value) {
    if (value < 50) {
      return Colors.yellow;
    } else if (value < 80) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  void playBeep(double value) {
    if (value >= 80) {
          BeepPlayer.play(_beepFile);
    }
  }

  void toggleGenerating() {
    setState(() {
      isGenerating = !isGenerating;
      if (isGenerating) {
        startGenerating();
      } else {
        timer.cancel();
        data = [0];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            onPressed: () {
              toggleGenerating();
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                isGenerating ? 'Turn Off' : 'Track Heart-Rate',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          SizedBox(height: 20),
          HealthDataDisplay(
            lastGeneratedValue: lastGeneratedValue,
            status: getHeartStatus(lastGeneratedValue),
            color: getHeartColor(lastGeneratedValue),
            callMethod: () => playBeep(lastGeneratedValue),
          ),
          SizedBox(height: 20),
          HealthChart(data: data),
        ],
      ),
    );
  }
}
