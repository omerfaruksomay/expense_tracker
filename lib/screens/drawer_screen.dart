import 'package:expense_tracker/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'drawer_items/dashboard_screen.dart';
import 'drawer_items/filters_screen.dart';
import 'drawer_items/settings_screen.dart';
import 'drawer_items/welcome_screen.dart';

import 'expense_related/expenses_screen.dart';

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
      'widget': FilterScreen(key: UniqueKey()),
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
              decoration: BoxDecoration(color: primaryColor),
              child: Row(
                children: [
                  Icon(
                    Icons.account_balance,
                    color: Colors.white,
                    size: 25.sp,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    drawerMenuHeader,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.sp,
                    ),
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
