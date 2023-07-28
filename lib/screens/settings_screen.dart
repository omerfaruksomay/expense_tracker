import 'package:flutter/material.dart';

import '/screens/categories_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

//todo-> tarih formatı

class _SettingsScreenState extends State<SettingsScreen> {
  String placeHolder = 'Expense Tracker Settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 150),
            child: Center(
              child: Text(
                placeHolder,
                style: const TextStyle(fontSize: 30),
              ),
            ),
          ),
          const SizedBox(height: 80),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const CategoriesScreen(),
                  ));
                },
                child: const Row(
                  children: [
                    Text('Categories'),
                    Spacer(),
                    Icon(Icons.arrow_forward),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
