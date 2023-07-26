import 'package:flutter/material.dart';
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
  final Category category;

  Expense({
    required this.id,
    required this.name,
    required this.amount,
    required this.date,
    required this.category,
  });

  String get formattedDate {
    return formatter.format(date);
  }
}

@HiveType(typeId: 2)
enum Category {
  @HiveField(0)
  diger,
  @HiveField(1)
  ulasim,
  @HiveField(2)
  konut,
  @HiveField(3)
  eglence,
  @HiveField(4)
  saglik,
  @HiveField(5)
  egitim,
}

const categoryIcons = {
  Category.diger: Icons.category,
  Category.ulasim: Icons.directions_car,
  Category.konut: Icons.home,
  Category.eglence: Icons.theaters,
  Category.saglik: Icons.local_hospital,
  Category.egitim: Icons.school,
};

const categoryName = {
  Category.diger: 'other',
  Category.ulasim: 'transportation',
  Category.konut: 'housing',
  Category.eglence: 'entertainment',
  Category.saglik: 'health care',
  Category.egitim: 'education',
};

//dummy data

List<Expense> dummyExpenses = [
  Expense(
    id: 1,
    name: 'test1',
    amount: 45,
    date: DateTime(2023, 07, 23),
    category: Category.diger,
  ),
  Expense(
    id: 2,
    name: 'test2',
    amount: 45,
    date: DateTime(2023, 06, 23),
    category: Category.egitim,
  ),
  Expense(
    id: 3,
    name: 'test3',
    amount: 45,
    date: DateTime(2023, 07, 21),
    category: Category.eglence,
  ),
  Expense(
    id: 4,
    name: 'test4',
    amount: 45,
    date: DateTime(2023, 07, 17),
    category: Category.konut,
  ),
  Expense(
    id: 5,
    name: 'test5',
    amount: 45,
    date: DateTime(2023, 07, 18),
    category: Category.saglik,
  ),
  Expense(
    id: 6,
    name: 'test6',
    amount: 45,
    date: DateTime(2023, 07, 19),
    category: Category.ulasim,
  ),
  Expense(
    id: 7,
    name: 'test7',
    amount: 45,
    date: DateTime(2023, 07, 23),
    category: Category.diger,
  ),
  Expense(
    id: 8,
    name: 'test8',
    amount: 45,
    date: DateTime(2023, 07, 22),
    category: Category.egitim,
  ),
  Expense(
    id: 9,
    name: 'test9',
    amount: 45,
    date: DateTime(2023, 07, 21),
    category: Category.eglence,
  ),
  Expense(
    id: 10,
    name: 'test10',
    amount: 45,
    date: DateTime(2023, 06, 23),
    category: Category.konut,
  ),
];
