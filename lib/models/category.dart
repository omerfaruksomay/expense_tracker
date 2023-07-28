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
  Category(id: 1, name: 'diger'),
  Category(id: 2, name: 'ev'),
  Category(id: 3, name: 'eğitim'),
  Category(id: 4, name: 'ulaşım'),
  Category(id: 5, name: 'eğlence'),
];
