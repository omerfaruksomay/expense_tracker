import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../models/expense.dart';

class DateFilter extends StatefulWidget {
  const DateFilter({super.key});

  @override
  State<DateFilter> createState() => _DateFilterState();
}

class _DateFilterState extends State<DateFilter> {
  DateTime? _filteredStartDate;
  DateTime? _filteredEndDate;

  DateTime? _startDate;
  DateTime? _endDate;

  void _onSelectionChanged(
      DateRangePickerSelectionChangedArgs dateRangePickerSelectionChangedArgs) {
    _startDate = dateRangePickerSelectionChangedArgs.value.startDate;
    _endDate = dateRangePickerSelectionChangedArgs.value.endDate;
    setState(() {
      _filteredStartDate = _startDate;
      _filteredEndDate = _endDate;
    });
  }

  List<Expense> _getFilteredExpenses() {
    if (_startDate == null || _endDate == null) {
      return [];
    }

    final expenseBox = Hive.box<Expense>('expenses');
    final expenses = expenseBox.values.toList();
    return expenses.where((expense) {
      return expense.date.isAfter(_filteredStartDate!) &&
          expense.date.isBefore(_filteredEndDate!.add(const Duration(days: 1)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          SfDateRangePicker(
            view: DateRangePickerView.month,
            monthViewSettings:
                const DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
            selectionMode: DateRangePickerSelectionMode.range,
            onSelectionChanged: _onSelectionChanged,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _getFilteredExpenses().length,
              itemBuilder: (context, index) {
                final expense = _getFilteredExpenses()[index];
                return Container(
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    title: Text(expense.name),
                    subtitle: Text(expense.amount.toString()),
                    trailing: Column(
                      children: [
                        Icon(categoryIcons[expense.category]),
                        const SizedBox(height: 5),
                        Text(formatter.format(expense.date)),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
