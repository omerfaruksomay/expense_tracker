import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:showcaseview/showcaseview.dart';

import '../category_related/categories_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String text = 'Expense Tracker Settings';

  final themeBox = Hive.box('themeBox');

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = themeBox.get('darkMode') ?? false;
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 150),
            child: Center(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/welcome_icon.png',
                    height: 250,
                  ),
                  Text(
                    text,
                    style: const TextStyle(fontSize: 30),
                  ),
                ],
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
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ShowCaseWidget(
                        builder: Builder(
                          builder: (context) => const CategoriesScreen(),
                        ),
                      ),
                    ),
                  );
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
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: ElevatedButton(
                onPressed: () {},
                child: Row(
                  children: [
                    const Text('Dark mode'),
                    const Spacer(),
                    Switch(
                      value: isDarkMode,
                      onChanged: (value) {
                        setState(() {
                          themeBox.put('darkMode', value);
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
