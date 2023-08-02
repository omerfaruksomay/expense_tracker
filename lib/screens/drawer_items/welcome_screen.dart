import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          Text(
            welcomeMessage,
            style: TextStyle(fontSize: 20.sp),
          ),
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