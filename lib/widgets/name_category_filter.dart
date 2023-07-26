import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/expense.dart';

class NameAndCategoryFilter extends StatefulWidget {
  const NameAndCategoryFilter({super.key});

  @override
  State<NameAndCategoryFilter> createState() => _NameAndCategoryFilterState();
}

class _NameAndCategoryFilterState extends State<NameAndCategoryFilter> {
  late final Box expenseBox;
  String? expenseName;
  final TextEditingController _nameContoller = TextEditingController();

  Category _selectedCategory = Category.diger;
  Category? _filteredCategory;

  @override
  void initState() {
    super.initState();
    expenseBox = Hive.box<Expense>('expenses');
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

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: expenseBox.listenable(),
      builder: (context, Box box, child) {
        Map<dynamic, dynamic> raw = box.toMap();

        List filteredExpenses = [];
        if (expenseName.toString().trim().toLowerCase().length > 0) {
          filteredExpenses = raw.values
              .where((expense) =>
                  expense.name
                      .toString()
                      .trim()
                      .toLowerCase()
                      .contains(expenseName.toString().trim().toLowerCase()) &&
                  expense.category == _filteredCategory)
              .toList();
        }

        return Expanded(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _nameContoller,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Expense Name',
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    DropdownButton(
                      value: _selectedCategory,
                      items: Category.values
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
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          expenseName = _nameContoller.text;
                          _filteredCategory = _selectedCategory;
                        });
                      },
                      child: Text('Filter'),
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredExpenses.length,
                  itemBuilder: (context, index) {
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
                                  onPressed: (context) => _deleteExpense(index),
                                  icon: Icons.delete,
                                  backgroundColor: Colors.red,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ],
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  borderRadius: BorderRadius.circular(10)),
                              child: InkWell(
                                child: ListTile(
                                  title: Text(filteredExpenses[index].name),
                                  subtitle: Text(filteredExpenses[index]
                                      .amount
                                      .toString()),
                                  trailing: Column(
                                    children: [
                                      Icon(categoryIcons[
                                          filteredExpenses[index].category]),
                                      const SizedBox(height: 5),
                                      Text(formatter.format(
                                          filteredExpenses[index].date)),
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
      },
    );
  }
}