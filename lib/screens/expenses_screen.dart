import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_flutter/adapters.dart';

import '/models/expense.dart';
import '/screens/add_expense.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  late final Box expenseBox;

  @override
  void initState() {
    // TODO: implement initState
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
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddExpenseScreen(),
            ),
          );
        }, // todo-> add expense screen
        child: const Icon(Icons.add),
      ),
      body: ValueListenableBuilder(
        valueListenable: expenseBox.listenable(),
        builder: (context, Box box, child) {
          if (box.isEmpty) {
            return const Center(
              child: Text('Add Some Expneses !'),
            );
          } else {
            return ListView.builder(
              itemCount: box.length,
              itemBuilder: (context, index) {
                var currentBox = box;
                var expenseData = currentBox.getAt(index)!;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Builder(
                          builder: (context) => Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
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
                                _deleteExpense(index);
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
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              borderRadius: BorderRadius.circular(10)),
                          child: InkWell(
                            child: ListTile(
                              title: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(expenseData.id.toString()),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(expenseData.name),
                                    ],
                                  )
                                ],
                              ),
                              subtitle: Text(expenseData.amount.toString()),
                              trailing: Column(
                                children: [
                                  Icon(categoryIcons[expenseData.category]),
                                  const SizedBox(height: 5),
                                  Text(formatter.format(expenseData.date)),
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
          }
        },
      ),
    );
  }
}
