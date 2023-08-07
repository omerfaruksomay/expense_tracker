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

  List<dynamic> categoryExpenses = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    expenseBox = Hive.box<Expense>('expenses');
    categoryBox = Hive.box<Category>('categories');
    getChartData();
  }

  getChartData() {
    DateTime now = DateTime.now();
    DateTime lastMonth = DateTime(now.year, now.month - 1, now.day);

    var lastMonthExpenses = expenseBox.values
        .where((expense) => expense.date.isAfter(lastMonth))
        .toList();

    for (var categories in categoryBox.values) {
      categoryExpenses
          .add({'id': categories.id, 'name': categories.name, 'amount': 0});
    }

    for (var expenses in lastMonthExpenses) {
      var amount = expenses.amount;
      var catId = expenses.categoryId;

      for (var catExpenses in categoryExpenses) {
        if (catExpenses['id'] == catId) {
          catExpenses['amount'] += amount;
        }
      }
    }

    setState(() {
      _chartData = categoryExpenses;
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
          xValueMapper: (data, index) => _chartData[index]['name'],
          yValueMapper: (data, index) => _chartData[index]['amount'],
          dataLabelSettings: const DataLabelSettings(isVisible: true),
        ),
      ],
    );
  }
}
