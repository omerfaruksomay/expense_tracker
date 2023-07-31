import 'package:flutter/material.dart';

import '../expense_related/add_expense.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String welcomeMessage = 'Welcome the Expense Tracker App !';
  String addExpenseButtonText = 'Lets Add Some Expense';

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
        ],
      ),
    );
  }
}
