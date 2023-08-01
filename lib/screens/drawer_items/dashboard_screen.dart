import 'package:flutter/material.dart';

import '../analysis/last_month_analysis.dart';
import '../analysis/overall_analysis.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
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
    return DefaultTabController(
      initialIndex: 0,
      length: tabs.length,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
                child: TabBar(
                  labelColor: Colors.black,
                  tabs: [
                    Tab(
                      text: tabs[0]['title'],
                    ),
                    Tab(
                      text: tabs[1]['title'],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(children: [
                  tabs[0]['widget'],
                  tabs[1]['widget'],
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
