import 'package:flutter/material.dart';

import '/widgets/category_filter.dart';
import '/widgets/date_category_filter.dart';
import '/widgets/date_filter.dart';
import '/widgets/date_name_filter.dart';
import '/widgets/name_category_filter.dart';
import '/widgets/name_filter.dart';
import '/widgets/all_filters.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _ToggleFilterState();
}

class _ToggleFilterState extends State<FilterScreen> {
  final List<Widget> filters = <Widget>[
    const Text('Category'),
    const Text('Name'),
    const Text('Date'),
  ];

  final List<bool> _selectedFilters = <bool>[false, false, false];

  @override
  Widget build(BuildContext context) {
    Widget content = const Row();

    if (_selectedFilters[0] == true &&
        _selectedFilters[1] == false &&
        _selectedFilters[2] == false) {
      content = const CategoryFilter();
    } else if (_selectedFilters[0] == false &&
        _selectedFilters[1] == true &&
        _selectedFilters[2] == false) {
      content = const NameFilter();
    } else if (_selectedFilters[0] == true &&
        _selectedFilters[1] == true &&
        _selectedFilters[2] == false) {
      content = const NameAndCategoryFilter();
    } else if (_selectedFilters[0] == true &&
        _selectedFilters[1] == false &&
        _selectedFilters[2] == true) {
      content = const DateAndCategoryFilter();
    } else if (_selectedFilters[0] == false &&
        _selectedFilters[1] == false &&
        _selectedFilters[2] == true) {
      content = const DateFilter();
    } else if (_selectedFilters[0] == false &&
        _selectedFilters[1] == true &&
        _selectedFilters[2] == true) {
      content = const DateAndNameFilter();
    } else if (_selectedFilters[0] == true &&
        _selectedFilters[1] == true &&
        _selectedFilters[2] == true) {
      content = const AllFilters();
    }

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            ToggleButtons(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              selectedBorderColor: Colors.deepPurple,
              fillColor: Colors.deepPurpleAccent,
              selectedColor: Colors.white,
              direction: Axis.horizontal,
              onPressed: (index) {
                setState(() {
                  _selectedFilters[index] = !_selectedFilters[index];
                });
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
