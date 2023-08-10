import 'package:expense_tracker/models/category.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class UpdateCategoryScreen extends StatefulWidget {
  const UpdateCategoryScreen({
    super.key,
    required this.id,
    required this.index,
    this.category,
    this.nameController,
  });

  final int id;
  final int index;
  final dynamic category;
  final nameController;

  @override
  State<UpdateCategoryScreen> createState() => _UpdateCategoryScreenState();
}

class _UpdateCategoryScreenState extends State<UpdateCategoryScreen> {
  late final Box categoryBox;
  late final TextEditingController _nameController;

  final _categoryFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categoryBox = Hive.box<Category>('categories');
    _nameController = TextEditingController(text: widget.nameController);
  }

  _updateCategory() {
    if (_categoryFormKey.currentState!.validate()) {
      final String categoryName = _nameController.text;

      bool categoryExists = false;
      for (final category in categoryBox.values) {
        if (category.name.toLowerCase() == categoryName.toLowerCase()) {
          categoryExists = true;
          break;
        }
      }

      if (!categoryExists) {
        final int id = widget.id;
        final updatedCategory = Category(
          id: id,
          name: categoryName,
        );
        categoryBox.putAt(widget.index, updatedCategory);

        Navigator.of(context).pop();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Category Updated!'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Category already exists!'),
          ),
        );
      }
    }
  }

  String? _fieldValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field can\'t be empty';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Category id: ${widget.id}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _categoryFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Category name',
                ),
                autocorrect: false,
                keyboardType: TextInputType.name,
                controller: _nameController,
                validator: _fieldValidator,
              ),
              const SizedBox(
                height: 12,
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop({'isUpdated': false});
                    },
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 15),
                  FilledButton(
                    onPressed: () {
                      if (_categoryFormKey.currentState!.validate()) {
                        _updateCategory();
                      }
                    },
                    child: const Text('Save'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
