import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_flutter/adapters.dart';

import '/models/expense.dart';
import '/models/category.dart';
import 'add_expense.dart';
import 'update_expense.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  late final Box expenseBox;
  late final Box categoryBox;

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
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddExpenseScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: ValueListenableBuilder(
        valueListenable: expenseBox.listenable(),
        builder: (context, Box box, child) {
          Map<dynamic, dynamic> raw = box.toMap();
          List<dynamic> expenses = raw.values.toList();
          expenses.sort(
            (a, b) => b.date.compareTo(a.date),
          );
          return ListView.builder(
            itemCount: expenses.length,
            itemBuilder: (context, index) {
              Category category = categoryBox.values
                  .firstWhere((cat) => cat.id == expenses[index].categoryId);
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
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(10)),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => UpdateExpenseScreeen(
                                id: expenses[index].id,
                                index: index,
                                expenseData: expenses,
                                name: expenses[index].name,
                                amount: expenses[index].amount,
                                date: expenses[index].date,
                              ),
                            ));
                          },
                          child: ListTile(
                            title: Text(expenses[index].name),
                            subtitle: Text(expenses[index].amount.toString()),
                            trailing: Column(
                              children: [
                                Text(category.name),
                                const SizedBox(height: 5),
                                Text(
                                  formatter.format(expenses[index].date),
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
          );
        },
      ),
    );
  }
}
