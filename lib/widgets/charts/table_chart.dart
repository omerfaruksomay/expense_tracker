import 'package:expense_tracker/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../models/category.dart';
import '../../models/expense.dart';

class TableChart extends StatefulWidget {
  const TableChart({super.key});

  @override
  State<TableChart> createState() => _TableChartState();
}

class _TableChartState extends State<TableChart> {
  late final Box expenseBox;
  late final Box categoryBox;
  late List<dynamic> _chartData;

  // chunk
  List veriler = [
    [1, 2, 3, 4, 5],
    [6, 7, 8, 9, 10],
    [
      11,
      {'ad': "yemek", "fiyat": 123}
    ]
  ];

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

  String formatCategoryName(String categoryName) {
    String tempName = categoryName.toString().trim();
    if (tempName.length > 5) {
      return tempName.substring(0, 5) + ".";
    }
    return tempName;
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

        // var category = categoryBox.get(categoryId);
        // String categoryName = category.name.toString().trim();
        // if (categoryName.length > 5) {
        //   categoryName = categoryName.substring(1, 5) + ".";
        // }
        // categoryName = "hehe";
        // _chartData[i].categoryName = "hehe";

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
    return SfCartesianChart(
      primaryXAxis: CategoryAxis(),
      primaryYAxis: NumericAxis(),
      series: <ChartSeries>[
        ColumnSeries(
          color: primaryColor,
          dataSource: _chartData,
          xValueMapper: (data, index) {
            return formatCategoryName(_chartData[index].categoryName);
          },
          yValueMapper: (data, index) => data.amount,
        ),
      ],
    );
  }
}
