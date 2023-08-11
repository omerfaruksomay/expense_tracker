import 'dart:ffi';

import 'package:expense_tracker/widgets/showcase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../models/expense.dart';
import '/models/category.dart';
import 'add_category.dart';
import '/screens/category_related/update_category.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  late final Box categoryBox;
  late final Box expenseBox;
  late final Box settingsBox;

  final GlobalKey globalKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categoryBox = Hive.box<Category>('categories');
    expenseBox = Hive.box<Expense>('expenses');
    settingsBox = Hive.box('launch');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ShowCaseWidget.of(context).startShowCase([globalKey]);
    });
  }

  int _getExpensesCountByCategoryId(int categoryId) {
    int count = 0;
    for (var i = 0; i < expenseBox.length; i++) {
      final expense = expenseBox.getAt(i) as Expense;
      if (expense.categoryId == categoryId) {
        count++;
      }
    }
    return count;
  }

  int _getTotalAmountOfExpensesByCategoryId(int categoryId) {
    int totalAmount = 0;
    for (var i = 0; i < expenseBox.length; i++) {
      final expense = expenseBox.getAt(i) as Expense;
      if (expense.categoryId == categoryId) {
        totalAmount += expense.amount;
      }
    }
    return totalAmount;
  }

  void _deleteExpensesByCategoryId(int categoryId) {
    final expensesToDelete = <int>[];

    for (var i = 0; i < expenseBox.length; i++) {
      final expense = expenseBox.getAt(i) as Expense;
      if (expense.categoryId == categoryId) {
        expensesToDelete.add(i);
      }
    }

    for (var index in expensesToDelete.reversed) {
      expenseBox.deleteAt(index);
    }
  }

  void _deleteCategoryAndExpenses(int index) {
    categoryBox.deleteAt(index);
    _deleteExpensesByCategoryId(index);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        duration: Duration(seconds: 3),
        content: Text('Category and associated expenses deleted!'),
      ),
    );
  }

  _deleteCategory(int index) async {
    if (index <= 4) {
      return ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 3),
          content: Text('Default categories cannot be deleted!'),
        ),
      );
    }

    final isConfirmed = await _showDeleteConfirmationDialog(index);
    if (isConfirmed) {
      _deleteCategoryAndExpenses(index);
    }
  }

  Future<bool> _showDeleteConfirmationDialog(int categoryId) async {
    final expensesCount = _getExpensesCountByCategoryId(categoryId);
    final totalAmount = _getTotalAmountOfExpensesByCategoryId(categoryId);

    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Delete Category'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                    'Deleting this category will also delete its associated expenses. Are you sure?'),
                const SizedBox(height: 10),
                Text('Associated Expenses: $expensesCount'),
                Text('Total Amount: $totalAmount'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Delete'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    bool isFirstLaunchCategoriesScreen =
        settingsBox.get('isFirstLaunchCategoriesScreen') ?? true;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (categoryBox.length > 11) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('You cant add more than 12 categories'),
              ),
            );
          } else {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AddCategoryScreen(),
              ),
            );
          }
        },
        child: const Icon(Icons.add),
      ),
      body: ValueListenableBuilder(
        valueListenable: categoryBox.listenable(),
        builder: (context, Box box, child) {
          Map<dynamic, dynamic> raw = box.toMap();
          dynamic categories = raw.values.toList();
          return AnimationLimiter(
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                if (isFirstLaunchCategoriesScreen) {
                  if (index == 0) {
                    return ShowcaseWidget(
                      onClick: () async {
                        await settingsBox.put(
                            'isFirstLaunchCategoriesScreen', false);
                      },
                      globalKey: globalKey,
                      title: 'Update and Delete',
                      desc:
                          'Touch to update Category, Slide to delete Category',
                      child: AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: Padding(
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
                                              _deleteCategory(
                                                  categories[index].id),
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
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  UpdateCategoryScreen(
                                                id: categories[index].id,
                                                index: index,
                                                category: categories,
                                                nameController:
                                                    categories[index].name,
                                              ),
                                            ),
                                          );
                                        },
                                        child: ListTile(
                                          title: Text(categories[index].name),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                }

                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: Padding(
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
                                        _deleteCategory(categories[index].id),
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
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            UpdateCategoryScreen(
                                          id: categories[index].id,
                                          index: index,
                                          category: categories,
                                          nameController:
                                              categories[index].name,
                                        ),
                                      ),
                                    );
                                  },
                                  child: ListTile(
                                    title: Text(categories[index].name),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
