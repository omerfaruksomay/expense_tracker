import 'package:expense_tracker/widgets/category_filter.dart';
import 'package:expense_tracker/widgets/name_category_filter.dart';
import 'package:expense_tracker/widgets/name_filter.dart';
import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _ToggleFilterState();
}

class _ToggleFilterState extends State<FilterScreen> {
  final List<Widget> filters = <Widget>[
    const Text('Category'),
    const Text('Name'),
  ];

  final List<bool> _selectedFilters = <bool>[false, false];

  @override
  Widget build(BuildContext context) {
    Widget content = const Row();

    if (_selectedFilters[0] == true && _selectedFilters[1] == false) {
      content = const CategoryFilter();
    } else if (_selectedFilters[0] == false && _selectedFilters[1] == true) {
      content = const NameFilter();
    } else if (_selectedFilters[0] == true && _selectedFilters[1] == true) {
      content = const NameAndCategoryFilter();
    }

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            ToggleButtons(
              direction: Axis.horizontal,
              onPressed: (index) {
                setState(() {
                  _selectedFilters[index] = !_selectedFilters[index];
                });
                print(_selectedFilters[index]);
              },
              isSelected: _selectedFilters,
              children: filters,
            ),
            content,
          ],
        ),
      ),
    );
  }
}
