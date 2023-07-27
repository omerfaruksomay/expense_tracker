import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_flutter/adapters.dart';

import '/models/expense.dart';
import '/models/category.dart';
import '/screens/add_expense.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  late final Box expenseBox;
  late final Box categoryBox;

  List<dynamic> getExpenses() {
    return expenseBox.values.toList();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    expenseBox = Hive.box<Expense>('expenses');
    categoryBox = Hive.box<Category>('categories');
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
    List<dynamic> expenses = getExpenses();
    return Scaffold(
      body: ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, index) {
          Expense expense = expenses[index];
          Category category = categoryBox.values
              .firstWhere((cat) => cat.id == expense.categoryId);
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Builder(
                    builder: (context) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(color: Colors.red),
                    ),
                  ),
                ),
                Slidable(
                  endActionPane: ActionPane(
                    motion: const StretchMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          setState(() {
                            _deleteExpense(index);
                          });
                        },
                        icon: Icons.delete,
                        backgroundColor: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ],
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(10)),
                    child: InkWell(
                      child: ListTile(
                        title: Text(expense.name),
                        subtitle: Text(expense.amount.toString()),
                        trailing: Column(
                          children: [
                            Text(category.name),
                            const SizedBox(height: 5),
                            Text(formatter.format(expense.date)),
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
    );
  }
}
