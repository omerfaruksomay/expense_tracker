import 'package:expense_tracker/models/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../models/expense.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _ToggleFilterState();
}

class _ToggleFilterState extends State<FilterScreen> {
  late final Box<Expense> expenseBox;
  late final Box<Category> categoryBox;

  String? expenseName;
  final TextEditingController _nameContoller = TextEditingController();

  DateTime? _selectedDate;
  DateTime? _filteredDate;

  Category? _selectedCategory;
  Category? _filteredCategory;

  @override
  void initState() {
    super.initState();
    expenseBox = Hive.box<Expense>('expenses');
    categoryBox = Hive.box<Category>('categories');
  }

  _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 3, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  _deleteExpense(int index) {
    expenseBox.deleteAt(index);
    print('İtem Deleted');
    return ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        duration: Duration(seconds: 3),
        content: Text('Expense deleted !'),
      ),
    );
  }

  final List<Widget> filters = <Widget>[
    const Text('Category'),
    const Text('Name'),
    const Text('Date'),
  ];

  final List<bool> _selectedFilters = <bool>[false, false, false];

  @override
  Widget build(BuildContext context) {
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
            ValueListenableBuilder(
              valueListenable: expenseBox.listenable(),
              builder: (context, Box box, child) {
                Map<dynamic, dynamic> raw = box.toMap();
                dynamic filteredExpenses;

                if (_selectedFilters[0] == true &&
                    _selectedFilters[1] == true &&
                    _selectedFilters[2] == true) {
                  filteredExpenses = raw.values
                      .where((expense) =>
                          expense.date == _selectedDate &&
                          expense.name.toString().trim().toLowerCase().contains(
                              expenseName.toString().trim().toLowerCase()) &&
                          expense.categoryId == _filteredCategory!.id)
                      .toList();
                } else if (_selectedFilters[0] == false &&
                    _selectedFilters[1] == false &&
                    _selectedFilters[2] == false) {
                  filteredExpenses = raw.values.toList();
                } else if (_selectedFilters[0] == true &&
                    _selectedFilters[1] == false &&
                    _selectedFilters[2] == false) {
                  if (_filteredCategory != null) {
                    filteredExpenses = raw.values
                        .where(
                          (expense) =>
                              expense.categoryId == _filteredCategory!.id,
                        )
                        .toList();
                  } else {
                    filteredExpenses = raw.values.toList();
                  }
                } else if (_selectedFilters[0] == false &&
                    _selectedFilters[1] == true &&
                    _selectedFilters[2] == false) {
                  filteredExpenses = raw.values
                      .where((expense) => expense.name
                          .toString()
                          .trim()
                          .toLowerCase()
                          .contains(
                              expenseName.toString().trim().toLowerCase()))
                      .toList();
                } else if (_selectedFilters[0] == false &&
                    _selectedFilters[1] == false &&
                    _selectedFilters[2] == true) {
                  filteredExpenses = raw.values
                      .where((expense) => expense.date == _selectedDate)
                      .toList();
                } else if (_selectedFilters[0] == true &&
                    _selectedFilters[1] == true &&
                    _selectedFilters[2] == false) {
                  filteredExpenses = raw.values
                      .where((expense) =>
                          expense.name.toString().trim().toLowerCase().contains(
                              expenseName.toString().trim().toLowerCase()) &&
                          expense.categoryId == _filteredCategory!.id)
                      .toList();
                } else if (_selectedFilters[0] == false &&
                    _selectedFilters[1] == true &&
                    _selectedFilters[2] == true) {
                  filteredExpenses = raw.values
                      .where((expense) =>
                          expense.date == _selectedDate &&
                          expense.name.toString().trim().toLowerCase().contains(
                              expenseName.toString().trim().toLowerCase()))
                      .toList();
                } else if (_selectedFilters[0] == true &&
                    _selectedFilters[1] == false &&
                    _selectedFilters[2] == true) {
                  filteredExpenses = raw.values
                      .where((expense) =>
                          expense.date == _selectedDate &&
                          expense.categoryId == _filteredCategory!.id)
                      .toList();
                }

                if (box.isEmpty) {
                  return const Center(
                    child: Text(
                      'Add Some Expenses !',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  );
                } else {
                  return Expanded(
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Visibility(
                                      visible: _selectedFilters[1],
                                      child: TextField(
                                        controller: _nameContoller,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Expense Name',
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Visibility(
                                      visible: _selectedFilters[0],
                                      child: DropdownButton(
                                        value: _selectedCategory,
                                        items: categoryBox.values
                                            .map(
                                              (category) => DropdownMenuItem(
                                                value: category,
                                                child: Text(
                                                  category.name.toUpperCase(),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                        onChanged: (value) {
                                          if (value == null) {
                                            return;
                                          }
                                          setState(() {
                                            _selectedCategory = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Visibility(
                              visible: _selectedFilters[2],
                              child: Row(
                                children: [
                                  Text(_selectedDate == null
                                      ? 'No Date Selected'
                                      : formatter.format(_selectedDate!)),
                                  IconButton(
                                    onPressed: _presentDatePicker,
                                    icon: const Icon(Icons.calendar_month),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Visibility(
                          visible: _selectedFilters[0] ||
                              _selectedFilters[1] ||
                              _selectedFilters[2],
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _filteredDate = _selectedDate;
                                expenseName = _nameContoller.text;
                                _filteredCategory = _selectedCategory;
                              });
                            },
                            child: const Text('Filter'),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: filteredExpenses.length,
                            itemBuilder: (context, index) {
                              Category category = categoryBox.values.firstWhere(
                                  (cat) =>
                                      cat.id ==
                                      filteredExpenses[index].categoryId);
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Stack(
                                  children: [
                                    Positioned.fill(
                                      child: Builder(
                                        builder: (context) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          child: Container(color: Colors.red),
                                        ),
                                      ),
                                    ),
                                    Slidable(
                                      endActionPane: ActionPane(
                                        motion: const StretchMotion(),
                                        children: [
                                          SlidableAction(
                                            onPressed: (context) =>
                                                _deleteExpense(index),
                                            icon: Icons.delete,
                                            backgroundColor: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ],
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primaryContainer,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: InkWell(
                                          child: ListTile(
                                            title: Text(
                                                filteredExpenses[index].name),
                                            subtitle: Text(
                                                filteredExpenses[index]
                                                    .amount
                                                    .toString()),
                                            trailing: Column(
                                              children: [
                                                Text(category.name),
                                                const SizedBox(height: 5),
                                                Text(
                                                  formatter.format(
                                                      filteredExpenses[index]
                                                          .date),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
