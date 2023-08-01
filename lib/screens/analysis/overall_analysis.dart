import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../widgets/charts/pie_chart.dart';
import '../../widgets/charts/table_chart.dart';

class OverallAnalysis extends StatefulWidget {
  const OverallAnalysis({super.key});

  @override
  State<OverallAnalysis> createState() => _OverallAnalysisState();
}

class _OverallAnalysisState extends State<OverallAnalysis> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        aspectRatio: 1.0,
        enlargeCenterPage: true,
        initialPage: 0,
        enableInfiniteScroll: false,
        enlargeFactor: 0.5,
      ),
      items: const [
        TableChart(),
        PieChart(),
      ],
    );
  }
}
