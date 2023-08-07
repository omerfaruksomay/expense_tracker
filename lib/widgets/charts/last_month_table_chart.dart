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

   getChartData(){

     DateTime now = DateTime.now();
    DateTime lastMonth = DateTime(now.year, now.month - 1, now.day);

   var lastMonthExpenses =expenseBox.values.where((expense) => expense.date.isAfter(lastMonth)).toList();


    for (var categories in categoryBox.values) {
      categoryExpenses.add({'id':categories.id,'name':categories.name,'amount':0});
    }

   

    
    for (var expenses in lastMonthExpenses) {
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
     return SfCartesianChart(
      primaryXAxis: CategoryAxis(),
      primaryYAxis: NumericAxis(),
      series: <ChartSeries>[
        ColumnSeries(
          color: primaryColor,
          dataSource: _chartData,
          xValueMapper: (data, index) {
            return (_chartData[index]['name']);
          },
          yValueMapper: (data, index) => _chartData[index]['amount'],
        ),
      ],
    )
     ;
  }
}




  // List<dynamic> getLastMonthExpenses(List<dynamic> expenses) {
  //   final DateTime now = DateTime.now();
  //   final DateTime lastMonth = DateTime(now.year, now.month - 1, now.day);

  //   return expenses
  //       .where((expense) => expense.date.isAfter(lastMonth))
  //       .toList();
  // }