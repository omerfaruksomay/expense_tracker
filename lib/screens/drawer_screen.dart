import 'package:flutter/material.dart';

import '/screens/filter_prac.dart';
import 'dashboard_screen.dart';
import 'expenses_screen.dart';
import 'filters_screen.dart';
import 'settings_screen.dart';
import 'welcome_screen.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  String appBarTitle = 'Expense Tracker';
  String drawerMenuHeader = 'Expense Tracker';

  int _selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appBarTitle = screens[_selectedIndex]['title'];
  }

  void _onMenuItemClicked(int index) {
    setState(() {
      _selectedIndex = index;
      appBarTitle = screens[index]['title'];
    });
    Navigator.pop(context);
  }

  List screens = [
    {
      'title': 'Welcome',
      'icon': Icons.home,
      'index': 0,
      'widget': WelcomeScreen(key: UniqueKey()),
    },
    {
      'title': 'Dashboard',
      'icon': Icons.dashboard,
      'index': 1,
      'widget': DashboardScreen(key: UniqueKey()),
    },
    {
      'title': 'Expenses',
      'icon': Icons.attach_money,
      'index': 2,
      'widget': ExpensesScreen(key: UniqueKey()),
    },
    {
      'title': 'Filters',
      'icon': Icons.search,
      'index': 3,
      'widget': FiltersScreen(key: UniqueKey()),
    },
    {
      'title': 'Settings',
      'icon': Icons.settings,
      'index': 4,
      'widget': SettingsScreen(key: UniqueKey()),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          appBarTitle,
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Row(
                children: [
                  const Icon(
                    Icons.account_balance,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    drawerMenuHeader,
                    style: const TextStyle(),
                  ),
                ],
              ),
            ),
            ...screens.map((screenObject) {
              return ListTile(
                selected: _selectedIndex == screenObject['index'],
                leading: Icon(screenObject['icon']),
                title: Text(screenObject['title']),
                onTap: () => _onMenuItemClicked(screenObject['index']),
              );
            }).toList(),
          ],
        ),
      ),
      body: screens[_selectedIndex]['widget'],
    );
  }
}
