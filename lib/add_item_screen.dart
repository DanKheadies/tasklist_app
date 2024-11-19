import 'package:flutter/material.dart';
import 'package:tasklist_app/func.dart';
import 'package:tasklist_app/view_list_screen.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();

  static const routeName = '/add-item';
}

class _AddItemScreenState extends State<AddItemScreen> with Func {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ItemArguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add New Item to ${args.listName}',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: 'Enter task item',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter item name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  hintText: 'Enter description',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter item description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: 100,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await createItem(
                        args.listId,
                        nameController.text,
                        descriptionController.text,
                        false,
                      );
                      if (context.mounted) {
                        Navigator.pushNamed(
                          context,
                          ViewListScreen.routeName,
                          arguments: ViewArguments(
                            listName: args.listName,
                            id: args.listId,
                          ),
                        );
                      }
                    }
                  },
                  // style: ElevatedButton.styleFrom(
                  //   shape: const StadiumBorder(),
                  // ),
                  child: const Text('Add'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemArguments {
  final String listId;
  final String listName;

  const ItemArguments({
    required this.listId,
    required this.listName,
  });
}
