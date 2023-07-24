import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat('yyyy-MM-dd');

class Expense {
  final int id;
  final String name;
  final int amount;
  final DateTime date;
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

enum Category {
  diger,
  ulasim,
  konut,
  eglence,
  saglik,
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
  Category.diger: 'Diğer Harcamalar',
  Category.ulasim: 'Ulaşım Haracamaları',
  Category.konut: 'Konut Haracamaları',
  Category.eglence: 'Eğlence Haracamaları',
  Category.saglik: 'Sağlık Haracamaları',
  Category.egitim: 'Eğitim Haracamaları',
};
