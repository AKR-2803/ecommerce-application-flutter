import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:ecommerce_major_project/features/admin/widgets/bar_graph/bar_data.dart';

class MyBarGraph extends StatelessWidget {
  final List weeklySummary;
  const MyBarGraph({super.key, required this.weeklySummary});

  @override
  Widget build(BuildContext context) {
    BarData myBarData = BarData(
      sunAmount: weeklySummary[0],
      monAmount: weeklySummary[1],
      tueAmount: weeklySummary[2],
      wedAmount: weeklySummary[3],
      thuAmount: weeklySummary[4],
      friAmount: weeklySummary[5],
      satAmount: weeklySummary[6],
    );

    myBarData.initializeBar();

    return BarChart(
      BarChartData(
        maxY: 200,
        minY: 0,
        barGroups: myBarData.barData
            .map((data) => BarChartGroupData(
                x: data.x, barRods: [BarChartRodData(toY: data.y)]))
            .toList(),
      ),
    );
  }
}
