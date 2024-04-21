import 'package:flutter/material.dart';

class HealthDataDisplay extends StatelessWidget {
  final double lastGeneratedValue;
  final String status;
  final Color color;

  const HealthDataDisplay({
    required this.lastGeneratedValue,
    required this.status,
    required this.color, required callMethod,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: color,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite,
            size: 60,
            color: Colors.white,
          ),
          SizedBox(height: 10),
          Text(
            lastGeneratedValue.toStringAsFixed(2),
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          SizedBox(height: 10),
          Text(
            status,
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
