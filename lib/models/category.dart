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

List<Category> dummyCategories = [Category(id: 1, name: 'diger')];
