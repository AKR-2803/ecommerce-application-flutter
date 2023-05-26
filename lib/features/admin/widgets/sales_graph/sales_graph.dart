import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:ecommerce_major_project/main.dart';
import 'package:ecommerce_major_project/features/admin/widgets/sales_graph/sales_data.dart';

class SalesGraph extends StatelessWidget {
  final List salesSummary;
  const SalesGraph({super.key, required this.salesSummary});

  @override
  Widget build(BuildContext context) {
    SalesData mySalesData = SalesData(
      mobileSales: salesSummary[0],
      essentialsSales: salesSummary[1],
      booksSales: salesSummary[2],
      appliancesSales: salesSummary[3],
      fashionSales: salesSummary[4],
    );

    mySalesData.initializeBar();

    return BarChart(
      swapAnimationCurve: Curves.ease,
      swapAnimationDuration: const Duration(seconds: 1),
      BarChartData(
        maxY: 500000,
        minY: 0,
        gridData: FlGridData(show: false),
        backgroundColor: Colors.white,
        borderData: FlBorderData(
          // show: false,
          border: Border.all(
            width: 0.1,
            color: Colors.black,
          ),
        ),
        barGroups: mySalesData.salesBarData
            .map(
              (data) => BarChartGroupData(
                x: int.parse(data.label),
                barRods: [
                  BarChartRodData(
                    borderSide: const BorderSide(color: Colors.black, width: 1),
                    toY: double.parse(data.earnings.toString()),
                    width: 25,
                    borderRadius: BorderRadius.circular(2),
                    color: Colors.grey.shade500,
                    backDrawRodData: BackgroundBarChartRodData(
                        show: true, toY: 5000, color: Colors.grey.shade100),
                  ),
                ],
              ),
            )
            .toList(),
        titlesData: titlesData,
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            tooltipBorder: const BorderSide(color: Colors.black, width: 1.5),
            tooltipBgColor: Colors.white60,
            tooltipPadding: EdgeInsets.all(mq.width * .0125).copyWith(top: 10),
            tooltipRoundedRadius: 5,
          ),
        ),
      ),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    const TextStyle style =
        TextStyle(fontWeight: FontWeight.bold, fontSize: 14);

    String titleText;

    switch (value.toInt()) {
      case 0:
        titleText = 'Mo.';
        break;
      case 1:
        titleText = 'Ess.';
        break;
      case 2:
        titleText = 'Bks.';
        break;
      case 3:
        titleText = 'Appl.';
        break;
      case 4:
        titleText = 'Fash.';
        break;
      default:
        titleText = '';
        break;
    }

    return SideTitleWidget(
        axisSide: meta.axisSide,
        space: 4,
        child: Text(titleText, style: style));
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        // leftTitles: AxisTitles(
        //   sideTitles: SideTitles(showTitles: false),
        // ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );
}
