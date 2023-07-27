import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

part 'expense.g.dart';

final formatter = DateFormat('yyyy-MM-dd');

@HiveType(typeId: 1)
class Expense {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final int amount;
  @HiveField(3)
  final DateTime date;
  @HiveField(4)
  final int categoryId;

  Expense({
    required this.id,
    required this.name,
    required this.amount,
    required this.date,
    required this.categoryId,
  });

  String get formattedDate {
    return formatter.format(date);
  }
}

//dummy data

List<Expense> dummyExpenses = [
  Expense(
    id: 1,
    name: 'test1',
    amount: 45,
    date: DateTime(2023, 07, 23),
    categoryId: 1,
  ),
  Expense(
    id: 2,
    name: 'test2',
    amount: 45,
    date: DateTime(2023, 06, 23),
    categoryId: 1,
  ),
  Expense(
    id: 3,
    name: 'test3',
    amount: 45,
    date: DateTime(2023, 07, 21),
    categoryId: 1,
  ),
  Expense(
    id: 4,
    name: 'test4',
    amount: 45,
    date: DateTime(2023, 07, 17),
    categoryId: 1,
  ),
  Expense(
    id: 5,
    name: 'test5',
    amount: 45,
    date: DateTime(2023, 07, 18),
    categoryId: 1,
  ),
  Expense(
    id: 6,
    name: 'test6',
    amount: 45,
    date: DateTime(2023, 07, 19),
    categoryId: 1,
  ),
  Expense(
    id: 7,
    name: 'test7',
    amount: 45,
    date: DateTime(2023, 07, 23),
    categoryId: 1,
  ),
  Expense(
    id: 8,
    name: 'test8',
    amount: 45,
    date: DateTime(2023, 07, 22),
    categoryId: 1,
  ),
  Expense(
    id: 9,
    name: 'test9',
    amount: 45,
    date: DateTime(2023, 07, 21),
    categoryId: 1,
  ),
  Expense(
    id: 10,
    name: 'test10',
    amount: 45,
    date: DateTime(2023, 06, 23),
    categoryId: 1,
  ),
];
