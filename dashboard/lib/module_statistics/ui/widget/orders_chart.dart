import 'package:c4d/module_theme/service/theme_service/theme_service.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../model/statistics_model.dart';

class OrdersChart extends StatefulWidget {
  final StatisticsOrder statisticsOrder;

  OrdersChart({
    Key? key,
    required this.statisticsOrder,
  }) : super(key: key);

  final Color barColor = AppThemeDataService.PrimaryColor;
  final Color avgColor = Colors.yellowAccent;
  @override
  State<StatefulWidget> createState() => OrdersChartState();
}

class OrdersChartState extends State<OrdersChart> {
  final double barWidth = 13;
  late double maxOrder;

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex = -1;

  @override
  void initState() {
    super.initState();

    maxOrder = getMaxOrder(widget.statisticsOrder).toDouble();
    rawBarGroups = getBarChartGroupData(widget.statisticsOrder);

    showingBarGroups = rawBarGroups;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(),
      child: AspectRatio(
        aspectRatio: 6 / 2,
        child: Card(
          child: BarChart(
            BarChartData(
              maxY: maxOrder + maxOrder * 0.2,
              barTouchData: BarTouchData(
                touchCallback: (FlTouchEvent event, response) {
                  if (response == null || response.spot == null) {
                    setState(() {
                      touchedGroupIndex = -1;
                      showingBarGroups = List.of(rawBarGroups);
                    });
                    return;
                  }

                  touchedGroupIndex = response.spot!.touchedBarGroupIndex;

                  setState(() {
                    if (!event.isInterestedForInteractions) {
                      touchedGroupIndex = -1;
                      showingBarGroups = List.of(rawBarGroups);
                      return;
                    }
                    showingBarGroups = List.of(rawBarGroups);
                    if (touchedGroupIndex != -1) {
                      showingBarGroups[touchedGroupIndex] =
                          showingBarGroups[touchedGroupIndex].copyWith(
                        barRods: showingBarGroups[touchedGroupIndex]
                            .barRods
                            .map((rod) {
                          return rod.copyWith(color: widget.avgColor);
                        }).toList(),
                      );
                    }
                  });
                },
              ),
              titlesData: FlTitlesData(
                show: true,
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: bottomTitles,
                    reservedSize: 42,
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 28,
                    interval: 1,
                    getTitlesWidget: leftTitles,
                  ),
                ),
              ),
              borderData: FlBorderData(
                show: false,
              ),
              barGroups: showingBarGroups,
              gridData: FlGridData(show: false),
            ),
          ),
        ),
      ),
    );
  }

  List<BarChartGroupData> getBarChartGroupData(
      StatisticsOrder statisticsOrder) {
    List<BarChartGroupData> list = [];

    for (int i = 0; i < 7; i++) {
      list.add(
          makeGroupData(i, statisticsOrder.dailyOrders[i].count.toDouble()));
    }

    return list;
  }

  int getMaxOrder(StatisticsOrder statisticsOrder) {
    var daily = statisticsOrder.dailyOrders;
    int max = daily[0].count;

    for (var day in daily) if (max < day.count) max = day.count;

    return max;
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;

    if (value == 0) {
      text = '0';
    } else if (value == maxOrder / 2) {
      text = '${(maxOrder ~/ 2)}';
    } else if (value == maxOrder) {
      text = maxOrder.toInt().toString();
    } else {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text(text, style: style),
    );
  }

  List<String> getDayNameList() {
    var list = [
      'Mn',
      'Te',
      'Wd',
      'Tu',
      'Fr',
      'St',
      'Su',
      'Mn',
      'Te',
      'Wd',
      'Tu',
      'Fr',
      'St',
      'Su'
    ];
    var result = <String>[];

    int day = DateTime.now().weekday;
    for (int i = 0; i < 7; i++) {
      result.add(list[day++]);
    }

    return result;
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    DateTime now = DateTime.now();
    now.weekday;
    final titles = getDayNameList();

    final Widget text = Text(
      titles[value.toInt()],
      style: const TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16, //margin top
      child: text,
    );
  }

  BarChartGroupData makeGroupData(int x, double y1) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: widget.barColor,
          width: barWidth,
        ),
      ],
    );
  }
}
