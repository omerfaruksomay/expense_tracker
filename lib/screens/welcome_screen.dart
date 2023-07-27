import 'package:expense_tracker/screens/add_category.dart';
import 'package:flutter/material.dart';

import '/screens/add_expense.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String welcomeMessage = 'Welcome the Expense Tracker App !';
  String addExpenseButtonText = 'Lets Add Some Expense';
  String addCategoryButtonText = 'Lets Add Some Category';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(welcomeMessage),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const AddExpenseScreen(),
              ));
            },
            child: Text(addExpenseButtonText),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddCategoryScreen(),
                ),
              );
            },
            child: Text(addCategoryButtonText),
          ),
        ],
      ),
    );
  }
}
