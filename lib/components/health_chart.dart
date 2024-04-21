import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HealthChart extends StatelessWidget {
  final List<double> data;

  const HealthChart({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey[200],
      ),
      child: LineChart(
        LineChartData(
          minY: 0,
          maxY: 200,
          titlesData: FlTitlesData(
            leftTitles: SideTitles(
              showTitles: true,
              getTitles: (value) {
                switch (value.toInt()) {
                  case 0:
                    return 'Resting';
                  case 60:
                    return 'Normal';
                  case 100:
                    return 'High';
                  default:
                    return '';
                }
              },
            ),
            bottomTitles: SideTitles(
              showTitles: true,
              getTitles: (value) {
                return value.toInt().toString();
              },
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: data.asMap().entries.map((entry) {
                return FlSpot(entry.key.toDouble(), entry.value);
              }).toList(),
              isCurved: true,
              colors: [Colors.blue], // Adjust color as needed
              barWidth: 2,
              isStrokeCapRound: true,
              belowBarData: BarAreaData(show: false),
            ),
          ],
        ),
      ),
    );
  }
}
