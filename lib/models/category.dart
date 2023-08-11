import 'package:hive/hive.dart';

part 'category.g.dart';

@HiveType(typeId: 2)
class Category {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;

  Category({
    required this.id,
    required this.name,
  });
}

//dummy category

List<Category> defaultCategories = [
  Category(id: 0, name: 'Other'),
  Category(id: 1, name: 'Housing'),
  Category(id: 2, name: 'Education'),
  Category(id: 3, name: 'Transportation'),
  Category(id: 4, name: 'Entertainment'),
  Category(id: 5, name: 'Holiday')
];
