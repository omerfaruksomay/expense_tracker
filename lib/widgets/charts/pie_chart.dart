import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../models/category.dart';
import '../../models/expense.dart';

class PieChart extends StatefulWidget {
  const PieChart({super.key});

  @override
  State<PieChart> createState() => _PieChartState();
}

class _PieChartState extends State<PieChart> {
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

   getChartData(){
    for (var categories in categoryBox.values) {
      categoryExpenses.add({'id':categories.id,'name':categories.name,'amount':0});
    }
 
    
    for (var expenses in expenseBox.values) {
      var amount = expenses.amount;
      var catId = expenses.categoryId;

      for (var catExpenses in categoryExpenses) {
        if(catExpenses['id']==catId){
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
