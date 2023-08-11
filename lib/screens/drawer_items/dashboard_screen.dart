import 'package:expense_tracker/widgets/showcase.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:showcaseview/showcaseview.dart';

import '../analysis/last_month_analysis.dart';
import '../analysis/overall_analysis.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey globalKeyTabBar = GlobalKey();

  late final Box settingsBox;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    settingsBox = Hive.box('launch');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ShowCaseWidget.of(context).startShowCase([globalKeyTabBar]);
    });
  }

  List tabs = [
    {
      'title': 'Overall',
      'widget': const OverallAnalysis(),
    },
    {
      'title': 'Last Month',
      'widget': const LastMonthAnalysis(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    bool firstLaunchDashoardScreen =
        settingsBox.get('isFirstLaunchDashboardScreen') ?? true;

    Widget content = Center();

    if (firstLaunchDashoardScreen) {
      content = ShowcaseWidget(
        desc: 'Select overall analysis or last month analysis',
        title: 'Overall or Last month',
        globalKey: globalKeyTabBar,
        onClick: () async {
          await settingsBox.put('isFirstLaunchDashboardScreen', false);
        },
        child: TabBar(
          tabs: [
            Tab(
              text: tabs[0]['title'],
            ),
            Tab(
              text: tabs[1]['title'],
            ),
          ],
        ),
      );
    } else {
      content = TabBar(
        tabs: [
          Tab(
            text: tabs[0]['title'],
          ),
          Tab(
            text: tabs[1]['title'],
          ),
        ],
      );
    }

    return DefaultTabController(
      initialIndex: 0,
      length: tabs.length,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 8, right: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
                child: content,
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    tabs[0]['widget'],
                    tabs[1]['widget'],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
