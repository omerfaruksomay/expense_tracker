import 'package:expense_tracker/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../models/category.dart';
import '../../models/expense.dart';

class LastMonthTableChart extends StatefulWidget {
  const LastMonthTableChart({super.key});

  @override
  State<LastMonthTableChart> createState() => _TableChartState();
}

class _TableChartState extends State<LastMonthTableChart> {
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

  void getChartData() {
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

  List<List<dynamic>> _groupedChartData(List<dynamic> chartData) {
    List<List<dynamic>> groupedCharts = [];
    const int groupSize = 3;

    for (var i = 0; i < chartData.length; i += groupSize) {
      if (i + groupSize > chartData.length) {
        groupedCharts.add(chartData.sublist(i, chartData.length));
      } else {
        groupedCharts.add(chartData.sublist(i, i + groupSize));
      }
    }

    return groupedCharts;
  }

  @override
  Widget build(BuildContext context) {
    List<List<dynamic>> groupedChartData = _groupedChartData(_chartData);
    print(groupedChartData);
    return Column(
      children: [
        SizedBox(height: 15),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Swipe right to see pie chart'),
            Icon(Icons.arrow_right),
          ],
        ),
        const SizedBox(height: 15),
        Expanded(
          child: ListView.builder(
            itemCount: groupedChartData.length,
            itemBuilder: (context, index) {
              final chartData = groupedChartData[index];
              return SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                primaryYAxis: NumericAxis(),
                series: <ChartSeries>[
                  ColumnSeries(
                    color: primaryColor,
                    dataSource: chartData,
                    xValueMapper: (data, _) => data['name'].toString(),
                    yValueMapper: (data, _) => data['amount'],
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
