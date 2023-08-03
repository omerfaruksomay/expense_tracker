import 'package:expense_tracker/models/category.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '/models/expense.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  late final Box expenseBox;
  late final Box categoryBox;

  final _nameController = TextEditingController();
  final _amaountController = TextEditingController();

  DateTime? _selectedDate;
  String? _selectedCategory;

  final _expenseFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    expenseBox = Hive.box<Expense>('expenses');
    categoryBox = Hive.box<Category>('categories');
  }

  void _presentDatePicker() async {
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

  _addExpense() async {
    final int id = expenseBox.length + 1;
    final enteredAmount = int.parse(_amaountController.text);
    final int categoryId = categoryBox.values
        .firstWhere((category) => category.name == _selectedCategory)
        .id;

    Expense newExpense = Expense(
      id: id,
      name: _nameController.text,
      amount: enteredAmount,
      date: _selectedDate!,
      categoryId: categoryId,
    );

    expenseBox.add(newExpense);

    return ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Expesnse Added!'),
      ),
    );
  }

  String? _fieldValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field can\'t be empty';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Expense'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Form(
            key: _expenseFormKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Expense name',
                  ),
                  autocorrect: false,
                  keyboardType: TextInputType.name,
                  controller: _nameController,
                  validator: _fieldValidator,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Amount',
                  ),
                  autocorrect: false,
                  keyboardType: TextInputType.number,
                  controller: _amaountController,
                  validator: _fieldValidator,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _selectedCategory,
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory = value;
                          });
                        },
                        items: categoryBox.values
                            .map((category) => DropdownMenuItem<String>(
                                  value: category.name,
                                  child: Text(category.name),
                                ))
                            .toList(),
                        decoration: const InputDecoration(
                          labelText: 'Kategori',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Lütfen bir kategori seçin.';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () {
                          if (_expenseFormKey.currentState!.validate()) {
                            _addExpense();
                            Navigator.of(context).pop();
                          }
                        },
                        child: const Text('Save'),
                      ),
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }
}
