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

class ChartData {
  final int categoryId;
  final num amount;
  final String categoryName;

  ChartData(this.categoryId, this.amount, this.categoryName);
}

//dummy data

List<Expense> dummyExpenses = [
  Expense(
    id: 1,
    name: 'test1',
    amount: 25,
    date: DateTime(2023, 07, 23),
    categoryId: 1,
  ),
  Expense(
    id: 2,
    name: 'test2',
    amount: 35,
    date: DateTime(2023, 06, 23),
    categoryId: 2,
  ),
  Expense(
    id: 3,
    name: 'test3',
    amount: 55,
    date: DateTime(2023, 07, 21),
    categoryId: 3,
  ),
  Expense(
    id: 4,
    name: 'test4',
    amount: 85,
    date: DateTime(2023, 07, 17),
    categoryId: 4,
  ),
  Expense(
    id: 5,
    name: 'test5',
    amount: 95,
    date: DateTime(2023, 07, 18),
    categoryId: 3,
  ),
  Expense(
    id: 6,
    name: 'test6',
    amount: 75,
    date: DateTime(2023, 07, 19),
    categoryId: 1,
  ),
  Expense(
    id: 7,
    name: 'test7',
    amount: 15,
    date: DateTime(2023, 07, 23),
    categoryId: 2,
  ),
  Expense(
    id: 8,
    name: 'test8',
    amount: 5,
    date: DateTime(2023, 07, 22),
    categoryId: 3,
  ),
  Expense(
    id: 9,
    name: 'test9',
    amount: 145,
    date: DateTime(2023, 07, 21),
    categoryId: 4,
  ),
  Expense(
    id: 10,
    name: 'test10',
    amount: 245,
    date: DateTime(2023, 06, 23),
    categoryId: 4,
  ),
];
