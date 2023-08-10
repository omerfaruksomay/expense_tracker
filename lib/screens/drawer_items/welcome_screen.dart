import 'package:expense_tracker/widgets/showcase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:showcaseview/showcaseview.dart';

import '../expense_related/add_expense.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String welcomeMessage = 'Welcome the Expense Tracker App !';
  String addExpenseButtonText = 'Lets Add Some Expense';

  final GlobalKey globalKeyAddButton = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/welcome_icon.png',
            height: 300,
          ),
          SizedBox(
            child: Text(
              welcomeMessage,
              style: TextStyle(fontSize: 22.sp),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const AddExpenseScreen(),
              ));
            },
            child: Text(
              addExpenseButtonText,
              style: TextStyle(fontSize: 15.sp),
            ),
          ),
        ],
      ),
    );
  }
}
