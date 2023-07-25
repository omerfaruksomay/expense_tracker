import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String welcomeMessage = 'Welcome the Expense Tracker App !';
  String buttonText = 'Lets Add Some Expense';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(welcomeMessage),
          TextButton(onPressed: () {}, child: Text(buttonText))
        ],
      ),
    );
  }
}
