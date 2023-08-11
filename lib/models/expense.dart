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
    name: 'Rent Payment',
    amount: 1000,
    date: DateTime(2023, 07, 23),
    categoryId: 1,
  ),
  Expense(
    id: 2,
    name: 'Electricity Bill',
    amount: 135,
    date: DateTime(2023, 06, 23),
    categoryId: 1,
  ),
  Expense(
    id: 3,
    name: 'University Textbooks',
    amount: 255,
    date: DateTime(2023, 07, 21),
    categoryId: 2,
  ),
  Expense(
    id: 4,
    name: 'Student Loan Installment',
    amount: 485,
    date: DateTime(2023, 07, 17),
    categoryId: 2,
  ),
  Expense(
    id: 5,
    name: 'Movie Ticket',
    amount: 25,
    date: DateTime(2023, 07, 18),
    categoryId: 4,
  ),
  Expense(
    id: 6,
    name: 'Monthly Streaming Service Subscription',
    amount: 55,
    date: DateTime(2023, 07, 19),
    categoryId: 4,
  ),
  Expense(
    id: 7,
    name: 'Monthly Public Transport Pass',
    amount: 115,
    date: DateTime(2023, 07, 23),
    categoryId: 3,
  ),
  Expense(
    id: 8,
    name: 'Gasoline Expenses',
    amount: 300,
    date: DateTime(2023, 07, 22),
    categoryId: 3,
  ),
  Expense(
    id: 9,
    name: 'Health Insurance Premium',
    amount: 145,
    date: DateTime(2023, 07, 21),
    categoryId: 0,
  ),
  Expense(
    id: 10,
    name: 'Restaurant Meal',
    amount: 70,
    date: DateTime(2023, 06, 23),
    categoryId: 0,
  ),
  Expense(
    id: 10,
    name: 'Flight Tickets to a Tropical Destination',
    amount: 700,
    date: DateTime(2023, 06, 23),
    categoryId: 5,
  ),
  Expense(
    id: 10,
    name: 'Hotel Accommodation for a Week',
    amount: 670,
    date: DateTime(2023, 06, 23),
    categoryId: 5,
  ),
];
