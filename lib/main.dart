import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:showcaseview/showcaseview.dart';

import '/theme/theme_constants.dart';
import 'screens/drawer_screen.dart';
import '/models/category.dart';
import '/models/expense.dart';

void main() async {
  await Hive.initFlutter();
  //Adapters
  Hive.registerAdapter(ExpenseAdapter());
  Hive.registerAdapter(CategoryAdapter());
  //box
  var expenseBox = await Hive.openBox<Expense>('expenses');
  var catBox = await Hive.openBox<Category>('categories');
  await Hive.openBox('themeBox');

  if (catBox.isEmpty) {
    catBox.addAll(defaultCategories);
  }
  if (expenseBox.isEmpty) {
    expenseBox.addAll(dummyExpenses);
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Box themeBox;

  @override
  void initState() {
    super.initState();
    themeBox = Hive.box('themeBox');
    themeBox.listenable().addListener(_onThemeChange);
  }

  @override
  void dispose() {
    themeBox.listenable().removeListener(_onThemeChange);
    super.dispose();
  }

  void _onThemeChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = themeBox.get('darkMode') ?? false;
    return ScreenUtilInit(
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Expense Tracker App',
        theme: isDarkMode ? darkTheme : lighTheme,
        home: ShowCaseWidget(
            builder: Builder(
          builder: (context) => const DrawerScreen(),
        )),
      ),
      designSize: const Size(400, 800),
    );
  }
}
