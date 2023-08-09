import 'package:expense_tracker/screens/onbarding_screen.dart';
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
  var settingsBox = await Hive.openBox('launch');
  await Hive.openBox('themeBox');

  if (catBox.isEmpty) {
    catBox.addAll(defaultCategories);
  }
  if (expenseBox.isEmpty) {
    expenseBox.addAll(dummyExpenses);
  }

  bool firstLaunch = settingsBox.get('firstLaunch') ?? true;

  runApp(MyApp(
    firstLaunch: firstLaunch,
    settingsBox: settingsBox,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
    required this.firstLaunch,
    required this.settingsBox,
  });

  final bool firstLaunch;
  final Box settingsBox;
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
        home:
            widget.firstLaunch ? const OnbardingScreen() : const DrawerScreen(),
      ),
      designSize: const Size(400, 800),
    );
  }
}

//var olan ad tekrar eklenemesin -> validation
//category silme defaultlar silinmeyecek.
//Eklenen kategoriler silinebilecek. 
//Onboard screen ss ler kontrol edilecek.
//showcase view yapılacak.