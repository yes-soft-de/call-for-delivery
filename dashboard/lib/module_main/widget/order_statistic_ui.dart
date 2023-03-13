import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_main/model/statistics_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class OrderStatisticsUI extends StatefulWidget {
  final StatisticsOrder order;
  OrderStatisticsUI({Key? key, required this.order}) : super(key: key);

  @override
  State<OrderStatisticsUI> createState() => _OrderStatisticsUIState();
}

class _OrderStatisticsUIState extends State<OrderStatisticsUI> {
  bool extended = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 150,
              child: Text(
                S.current.totalOrdersCount,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              widget.order.allOrders.toString(),
              style: TextStyle(
                fontSize: 18,
                color: Colors.green,
              ),
            ),
            Text(
              S.current.sOrder,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Theme.of(context).scaffoldBackgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.background,
                    offset: Offset(0.5, 0.5),
                    spreadRadius: 2.5,
                    blurRadius: 6,
                  )
                ]),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  // last seven order
                  SizedBox(
                      height: 225,
                      child: _LineChart(
                        isShowingMainData: true,
                        order: widget.order,
                      )),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _LineChart extends StatelessWidget {
  final StatisticsOrder order;
  const _LineChart({required this.isShowingMainData, required this.order});

  final bool isShowingMainData;

  @override
  Widget build(BuildContext context) {
    return LineChart(
      sampleData1,
      swapAnimationDuration: const Duration(milliseconds: 250),
    );
  }

  LineChartData get sampleData1 => LineChartData(
        lineTouchData: lineTouchData1,
        gridData: gridData,
        titlesData: titlesData1,
        borderData: borderData,
        lineBarsData: lineBarsData1,
        minX: 0,
        maxX: 7,
        maxY: order.maxDeliveredPerDay.toDouble(),
        minY: order.minDeliveredPerDay.toDouble(),
      );

  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
      );

  FlTitlesData get titlesData1 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  List<LineChartBarData> get lineBarsData1 => [
        lineChartBarData1_1,
      ];

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff75729e),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    if (order.dailyOrders.any((element) => element.count == value)) {
      text = '${value.toInt()}';
    } else {
      return Container();
    }
    return Text(text, style: style, textAlign: TextAlign.center);
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 1,
        reservedSize: 40,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff72719b),
      fontWeight: FontWeight.bold,
      fontSize: 8,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = Text(order.dailyOrders[value.toInt()].date, style: style);
        break;
      case 1:
        text = Text(order.dailyOrders[value.toInt()].date, style: style);
        break;
      case 2:
        text = Text(order.dailyOrders[value.toInt()].date, style: style);
        break;
      case 3:
        text = Text(order.dailyOrders[value.toInt()].date, style: style);
        break;
      case 4:
        text = Text(order.dailyOrders[value.toInt()].date, style: style);
        break;
      case 5:
        text = Text(order.dailyOrders[value.toInt()].date, style: style);
        break;
      case 6:
        text = Text(order.dailyOrders[value.toInt()].date, style: style);
        break;
      default:
        text = const Text('');
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  FlGridData get gridData => FlGridData(show: true);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(color: Color(0xff4e4965), width: 4),
          left: BorderSide(color: Colors.transparent),
          right: BorderSide(color: Colors.transparent),
          top: BorderSide(color: Colors.transparent),
        ),
      );

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
      isCurved: true,
      color: const Color(0xff4af699),
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
      spots: getSpots());
  List<FlSpot> getSpots() {
    List<FlSpot> spots = [];
    double index = 0;
    order.dailyOrders.forEach((element) {
      spots.add(FlSpot(index, element.count.toDouble()));
      index++;
    });
    return spots;
  }
}
