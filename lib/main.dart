import 'package:expense_tracker/models/category.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'screens/drawer_screen.dart';

void main() async {
  await Hive.initFlutter();
  //Adapters
  Hive.registerAdapter(ExpenseAdapter());
  Hive.registerAdapter(CategoryAdapter());
  //box
  var expenseBox = await Hive.openBox<Expense>('expenses');
  var catBox = await Hive.openBox<Category>('categories');

  if (catBox.isEmpty) {
    catBox.addAll(defaultCategories);
  }
  if (expenseBox.isEmpty) {
    expenseBox.addAll(dummyExpenses);
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Expense Tracker App',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const DrawerScreen(),
    );
  }
}
