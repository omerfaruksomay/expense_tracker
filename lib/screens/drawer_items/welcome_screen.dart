import 'package:expense_tracker/widgets/showcase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:showcaseview/showcaseview.dart';

import '../expense_related/add_expense.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late final Box settingsBox;

  String welcomeMessage = 'Welcome the Expense Tracker App !';
  String addExpenseButtonText = 'Lets Add Some Expense';

  final GlobalKey globalKeyAddButton = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    settingsBox = Hive.box('launch');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ShowCaseWidget.of(context).startShowCase([globalKeyAddButton]);
    });
  }

  @override
  Widget build(BuildContext context) {
    bool firstLaunchWelcomeScreen =
        settingsBox.get('isFirstLaunchWelcomeScreen') ?? true;

    Widget content = Center();

    if (firstLaunchWelcomeScreen) {
      content = ShowcaseWidget(
        onClick: () async {
          await settingsBox.put('isFirstLaunchWelcomeScreen', false);
        },
        desc: 'Touch to add some Expense',
        title: 'Add expense',
        globalKey: globalKeyAddButton,
        child: TextButton(
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
      );
    } else {
      content = TextButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const AddExpenseScreen(),
          ));
        },
        child: Text(
          addExpenseButtonText,
          style: TextStyle(fontSize: 15.sp),
        ),
      );
    }

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
          content,
        ],
      ),
    );
  }
}
