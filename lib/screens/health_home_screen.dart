// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'dart:math';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:audioplayers/audioplayers.dart';

// void main() {
//   runApp(HealthApp());
// }

// class HealthApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Health App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: HealthHomeScreen(),
//     );
//   }
// }

// class HealthHomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: buildAppBar(),
//       body: HealthMonitor(),
//     );
//   }

//   AppBar buildAppBar() {
//     return AppBar(
//       title: buildAppBarTitle(),
//       centerTitle: true,
//       leading: IconButton(
//         icon: Icon(Icons.menu),
//         onPressed: () {},
//       ),
//       actions: [
//         IconButton(
//           icon: Icon(Icons.notifications),
//           onPressed: () {},
//         ),
//         IconButton(
//           icon: Icon(Icons.settings),
//           onPressed: () {},
//         ),
//       ],
//     );
//   }

//   Widget buildAppBarTitle() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Icon(Icons.favorite, color: Colors.red),
//         SizedBox(width: 10),
//         Text(
//           'Heart Rate App',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 20,
//             color: Colors.black,
//           ),
//         ),
//       ],
//     );
//   }
// }

// class HealthMonitor extends StatefulWidget {
//   @override
//   _HealthMonitorState createState() => _HealthMonitorState();
// }

// class _HealthMonitorState extends State<HealthMonitor> {
//   late Timer timer;
//   List<double> data = [0];
//   double lastGeneratedValue = 0;
//   bool isGenerating = false;

//   late AudioPlayer player = AudioPlayer();

//   @override
//   void dispose() {
//     timer.cancel();
//     super.dispose();
//   }

//   @override
//   void initState() {
//     super.initState();
//     player = AudioPlayer();

//     // startGenerating();
//   }

//   void startGenerating() {
//     timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       generateRandomValues();
//     });
//   }

//   void generateRandomValues() {
//     Random random = Random();
//     double value = random.nextDouble() * 100;
//     setState(() {
//       if (data.length >= 16) {
//         data.removeAt(0);
//       }
//       data.add(value);
//       lastGeneratedValue = value;
//     });

//     // Check heart rate status and play beep sound if status is high
//     if (getHeartStatus(lastGeneratedValue) == "High") {
//       player.setSource(AssetSource('beep.mp3'));
//       player.resume();
//       // Make sure to add the beep sound file (beep.mp3) to your assets folder
//     }
//   }

//   String getHeartStatus(double value) {
//     if (value < 50) {
//       return "Resting";
//     } else if (value < 80) {
//       return "Normal";
//     } else {
//       return "High";
//     }
//   }

//   Color getHeartColor(double value) {
//     if (value < 50) {
//       return Colors.yellow;
//     } else if (value < 80) {
//       return Colors.green;
//     } else {
//       return Colors.red;
//     }
//   }

//   void toggleGenerating() {
//     setState(() {
//       isGenerating = !isGenerating;
//       if (isGenerating) {
//         startGenerating();
//       } else {
//         timer.cancel();
//         data=[0];
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(20.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           ElevatedButton(
//             onPressed: () {
//               toggleGenerating();
//             },
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Text(
//                 isGenerating ? 'Turn Off' : 'Track Heart-Rate',
//                 style: TextStyle(fontSize: 18),
//               ),
//             ),
//           ),
//           SizedBox(height: 20),
//           HealthDataDisplay(
//             lastGeneratedValue: lastGeneratedValue,
//             status: getHeartStatus(lastGeneratedValue),
//             color: getHeartColor(lastGeneratedValue),
//           ),
//           SizedBox(height: 20),
//           HealthChart(data: data),
//         ],
//       ),
//     );
//   }
// }

// class HealthDataDisplay extends StatelessWidget {
//   final double lastGeneratedValue;
//   final String status;
//   final Color color;

//   const HealthDataDisplay({
//     required this.lastGeneratedValue,
//     required this.status,
//     required this.color,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 200,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         color: color,
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.favorite,
//             size: 60,
//             color: Colors.white,
//           ),
//           SizedBox(height: 10),
//           Text(
//             lastGeneratedValue.toStringAsFixed(2),
//             style: TextStyle(fontSize: 20, color: Colors.white),
//           ),
//           SizedBox(height: 10),
//           Text(
//             status,
//             style: TextStyle(fontSize: 16, color: Colors.white),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class HealthChart extends StatelessWidget {
//   final List<double> data;

//   const HealthChart({required this.data});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 300,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         color: Colors.grey[200],
//       ),
//       child: LineChart(
//         LineChartData(
//           minY: 0,
//           maxY: 200,
//           titlesData: FlTitlesData(
//             leftTitles: SideTitles(
//               showTitles: true,
//               getTitles: (value) {
//                 switch (value.toInt()) {
//                   case 0:
//                     return 'Resting';
//                   case 60:
//                     return 'Normal';
//                   case 100:
//                     return 'High';
//                   default:
//                     return '';
//                 }
//               },
//             ),
//             bottomTitles: SideTitles(
//               showTitles: true,
//               getTitles: (value) {
//                 return value.toInt().toString();
//               },
//             ),
//           ),
//           lineBarsData: [
//             LineChartBarData(
//               spots: data.asMap().entries.map((entry) {
//                 return FlSpot(entry.key.toDouble(), entry.value);
//               }).toList(),
//               isCurved: true,
//               colors: [Colors.blue], // Adjust color as needed
//               barWidth: 2,
//               isStrokeCapRound: true,
//               belowBarData: BarAreaData(show: false),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import '../components/health_monitor.dart';

class HealthHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: HealthMonitor(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: buildAppBarTitle(),
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {},
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.notifications),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget buildAppBarTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.favorite, color: Colors.red),
        SizedBox(width: 10),
        Text(
          'Heart Rate App',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

