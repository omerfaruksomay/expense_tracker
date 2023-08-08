import 'package:expense_tracker/widgets/showcase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:showcaseview/showcaseview.dart';

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

  final GlobalKey globalKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categoryBox = Hive.box<Category>('categories');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ShowCaseWidget.of(context).startShowCase([globalKey]);
    });
  }

  @override
  Widget build(BuildContext context) {
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
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              borderRadius: BorderRadius.circular(10)),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => UpdateCategoryScreen(
                                    id: categories[index].id,
                                    index: index,
                                    category: categories,
                                    nameController: categories[index].name,
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
