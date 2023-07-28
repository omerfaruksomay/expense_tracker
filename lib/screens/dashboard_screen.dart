import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '/models/category.dart';
import '/models/expense.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
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

  void totalAmount() {
    if (_chartData == null) {
      return;
    }

    Map<int, num> categoryExpenses = {};

    for (var i = 0; i < _chartData.length; i++) {
      var item = _chartData[i];
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
    return Scaffold(
      body: Container(
        height: 350,
        width: 400,
        child: SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          primaryYAxis: NumericAxis(),
          series: <ChartSeries>[
            ColumnSeries(
              dataSource: _chartData,
              xValueMapper: (data, index) {
                print('asdasdasd $index');
                return _chartData[index].categoryName;
              },
              yValueMapper: (data, index) => data.amount,
            ),
          ],
        ),
      ),
    );
  }
}
