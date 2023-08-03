import 'package:expense_tracker/models/category.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UpdateExpenseScreeen extends StatefulWidget {
  const UpdateExpenseScreeen({
    super.key,
    required this.id,
    required this.index,
    required this.expenseData,
    required this.name,
    required this.amount,
    required this.date,
  });

  final int id;
  final int index;
  final dynamic expenseData;

  final name;
  final amount;
  final date;

  @override
  State<UpdateExpenseScreeen> createState() => UpdateExpenseScreeenState();
}

class UpdateExpenseScreeenState extends State<UpdateExpenseScreeen> {
  late final Box categoryBox;
  late final Box expenseBox;

  late final TextEditingController _nameController;

  late final TextEditingController _amaountController;

  DateTime? _selectedDate;
  String? _selectedCategory;

  final _expenseFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    expenseBox = Hive.box<Expense>('expenses');
    categoryBox = Hive.box<Category>('categories');
    _nameController = TextEditingController(text: widget.name);
    _amaountController = TextEditingController(text: widget.amount.toString());
    _selectedDate = widget.date;
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

  _updateExpense() {
    final int id = widget.id;
    final enteredAmount = int.parse(_amaountController.text);
    final int categoryId = categoryBox.values
        .firstWhere((category) => category.name == _selectedCategory)
        .id;

    Expense updatedExpense = Expense(
      id: id,
      name: _nameController.text,
      amount: enteredAmount,
      date: _selectedDate!,
      categoryId: categoryId,
    );

    expenseBox.putAt(widget.index, updatedExpense);

    return ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Expesnse Updated!'),
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
        title: Text('Update Expense id: ${widget.id}'),
        centerTitle: true,
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
                        decoration: InputDecoration(labelText: 'Kategori'),
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
                            _updateExpense();
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
