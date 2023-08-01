import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../widgets/charts/last_month_pie_chart.dart';
import '../../widgets/charts/last_month_table_chart.dart';

class LastMonthAnalysis extends StatefulWidget {
  const LastMonthAnalysis({super.key});

  @override
  State<LastMonthAnalysis> createState() => _LastMonthAnalysisState();
}

class _LastMonthAnalysisState extends State<LastMonthAnalysis> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
          aspectRatio: 1.0,
          enlargeCenterPage: true,
          initialPage: 0,
          enableInfiniteScroll: false,
          enlargeFactor: 0.4),
      items: const [
        LastMonthTableChart(),
        LastMonthPieChart(),
      ],
    );
  }
}
