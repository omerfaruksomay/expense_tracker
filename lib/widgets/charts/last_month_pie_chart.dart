import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../models/category.dart';
import '../../models/expense.dart';

class LastMonthPieChart extends StatefulWidget {
  const LastMonthPieChart({super.key});

  @override
  State<LastMonthPieChart> createState() => _TableChartState();
}

class _TableChartState extends State<LastMonthPieChart> {
  late final Box expenseBox;
  late final Box categoryBox;
  late List<dynamic> _chartData;

  List<dynamic> getChartData() {
    var chartData = expenseBox.values.toList();
    return chartData;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    expenseBox = Hive.box<Expense>('expenses');
    categoryBox = Hive.box<Category>('categories');
    _chartData = getChartData();
    totalAmount();
  }

  String getCategoryName(int categoryId) {
    var category = categoryBox.get(categoryId);
    return category.name;
  }

  List<dynamic> getLastMonthExpenses(List<dynamic> expenses) {
    final DateTime now = DateTime.now();
    final DateTime lastMonth = DateTime(now.year, now.month - 1, now.day);

    return expenses
        .where((expense) => expense.date.isAfter(lastMonth))
        .toList();
  }

  void totalAmount() {
    if (_chartData == null) {
      return;
    }

    List<dynamic> lastMonthExpenses = getLastMonthExpenses(_chartData);
    Map<int, num> categoryExpenses = {};

    for (var i = 0; i < lastMonthExpenses.length; i++) {
      var item = lastMonthExpenses[i];
      if (item != null) {
        var categoryId = item.categoryId;
        var amount = item.amount;

        var category = categoryBox.get(categoryId);
        var categoryName = category.name;

        if (categoryExpenses.containsKey(categoryId)) {
          categoryExpenses[categoryId] =
              (categoryExpenses[categoryId] ?? 0) + amount;
        } else {
          categoryExpenses[categoryId] = amount;
        }
      }
    }

    final List<ChartData> chartData = categoryExpenses.entries
        .map((entry) =>
            ChartData(entry.key, entry.value, getCategoryName(entry.key)))
        .toList();

    setState(() {
      _chartData = chartData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      legend: const Legend(
          isVisible: true,
          overflowMode: LegendItemOverflowMode.wrap,
          position: LegendPosition.left),
      series: <CircularSeries>[
        PieSeries<dynamic, dynamic>(
          explode: true,
          dataSource: _chartData,
          xValueMapper: (data, index) => _chartData[index].categoryName,
          yValueMapper: (data, index) => _chartData[index].amount,
          dataLabelSettings: DataLabelSettings(isVisible: true),
        ),
      ],
    );
  }
}
