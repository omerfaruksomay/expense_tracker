import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../widgets/charts/last_month_pie_chart.dart';
import '../../widgets/charts/last_month_table_chart.dart';
import '../../widgets/charts/pie_chart.dart';
import '../../widgets/charts/table_chart.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Text('Overall'),
            CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 1.0,
                enlargeCenterPage: true,
                initialPage: 0,
              ),
              items: [
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 20, 50, 10),
                  child: const TableChart(),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 20, 50, 10),
                  child: const PieChart(),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.arrow_left),
                SizedBox(width: 5),
                Text('Swipe'),
                SizedBox(width: 5),
                Icon(Icons.arrow_right),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(thickness: 0.3),
            const SizedBox(height: 10),
            const Text('Last Month'),
            CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 1.0,
                enlargeCenterPage: true,
                initialPage: 0,
              ),
              items: [
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 20, 50, 10),
                  child: const LastMonthTableChart(),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 20, 50, 10),
                  child: const LastMonthPieChart(),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.arrow_left),
                SizedBox(width: 5),
                Text('Swipe'),
                SizedBox(width: 5),
                Icon(Icons.arrow_right),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(thickness: 0.3),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
