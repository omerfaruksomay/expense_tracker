import 'package:expense_tracker/widgets/category_filter.dart';
import 'package:expense_tracker/widgets/date_filter.dart';
import 'package:expense_tracker/widgets/name_filter.dart';
import 'package:flutter/material.dart';

import 'package:hive_flutter/adapters.dart';

import '../models/expense.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _filterIdentifier;

  @override
  Widget build(BuildContext context) {
    Widget content = Row();

    if (_filterIdentifier == 'category') {
      // print(_filterIdentifier);
      content = const CategoryFilter();
    }
    if (_filterIdentifier == 'name') {
      content = NameFilter();
    }
    if (_filterIdentifier == 'date') {
      content = DateFilter();
    }

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(left: 5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 120,
                  child: FilledButton(
                    onPressed: () {
                      setState(() {
                        _filterIdentifier = 'category';
                      });
                    },
                    child: const Text('Category'),
                  ),
                ),
                SizedBox(
                  width: 120,
                  child: FilledButton(
                    onPressed: () {
                      setState(() {
                        _filterIdentifier = 'name';
                      });
                    },
                    child: const Text('Name'),
                  ),
                ),
                SizedBox(
                  width: 120,
                  child: FilledButton(
                    onPressed: () {
                      setState(() {
                        _filterIdentifier = 'date';
                      });
                    },
                    child: const Text('Date'),
                  ),
                ),
              ],
            ),
            content,
          ],
        ),
      ),
    );
  }
}
