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
  Category(id: 0, name: 'Diğer'),
  Category(id: 1, name: 'Ev'),
  Category(id: 2, name: 'Eğitim'),
  Category(id: 3, name: 'Ulaşım'),
  Category(id: 4, name: 'Eğlence'),
];
