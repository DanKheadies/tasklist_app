import 'package:flutter/material.dart';
import 'package:tasklist_app/add_item_screen.dart';
import 'package:tasklist_app/func.dart';

class ViewListScreen extends StatefulWidget {
  const ViewListScreen({super.key});

  @override
  State<ViewListScreen> createState() => _ViewListScreenState();

  static const routeName = 'view-list';
}

class _ViewListScreenState extends State<ViewListScreen> with Func {
  bool editable = false;
  final TextEditingController nameController = TextEditingController();
  Map<int, bool> update = {};
  Map<int, TextEditingController> itemNameControllers = {};
  Map<int, TextEditingController> itemDescriptionControllers = {};
  Map<int, bool> completed = {};

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ViewArguments;
    nameController.text = args.listName;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            if (editable) {
              setState(() {
                editable = false;
              });
            } else {
              Navigator.of(context)
                  .pushNamed('/lists')
                  .then((value) => setState(() {}));
            }
          },
        ),
        title: editable
            ? TextField(
                controller: nameController,
              )
            : Text(
                args.listName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
        centerTitle: false,
        actions: args.all == true
            ? []
            : [
                IconButton(
                  onPressed: editable
                      ? () async {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                icon: const CircleAvatar(
                                  radius: 30,
                                  child: Icon(
                                    Icons.delete,
                                    size: 30,
                                  ),
                                ),
                                content: const Text(
                                  'Do you want to delete this list?',
                                ),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      await deleteList(args.id);
                                      if (context.mounted) {
                                        Navigator.pushNamed(context, '/lists')
                                            .then(
                                          (value) => setState(() {}),
                                        );
                                      }
                                    },
                                    child: const Text('Yes'),
                                  ),
                                  OutlinedButton(
                                    onPressed: () {
                                      setState(() {
                                        editable = false;
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      : () {
                          Navigator.of(context).pushNamed(
                            AddItemScreen.routeName,
                            arguments: ItemArguments(
                              listId: args.id,
                              listName: args.listName,
                            ),
                          );
                        },
                  icon: Icon(editable ? Icons.delete : Icons.add),
                ),
                IconButton(
                  onPressed: editable
                      ? () async {
                          await updateList(
                            args.id,
                            nameController.text.toString(),
                          );
                          if (context.mounted) {
                            Navigator.pushNamed(context, '/lists').then(
                              (value) => setState(() {}),
                            );
                          }
                        }
                      : () {
                          setState(() {
                            editable = true;
                          });
                        },
                  icon: Icon(editable ? Icons.save : Icons.edit),
                ),
              ],
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: args.all == true
            ? getItems(context)
            : getItemsByList(args.id, context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isNotEmpty) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  List itemsList = snapshot.data!.entries.toList();
                  itemNameControllers.putIfAbsent(
                    index,
                    () => TextEditingController(),
                  );
                  itemDescriptionControllers.putIfAbsent(
                    index,
                    () => TextEditingController(),
                  );
                  update.putIfAbsent(index, () => false);

                  return Dismissible(
                    key: UniqueKey(),
                    onDismissed: (direction) {
                      deleteItem(
                        itemsList[index].value['id'],
                      );
                    },
                    background: Container(
                      color: Colors.red,
                    ),
                    secondaryBackground: Container(
                      color: Colors.red,
                      child: const Padding(
                        padding: EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Delete item',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    child: Card(
                      child: ListTile(
                        leading: Checkbox(
                          value: itemsList[index].value['status'],
                          onChanged: (value) {
                            updateItem(
                              itemsList[index].value['id'],
                              args.id,
                              itemsList[index].value['name'],
                              itemsList[index].value['description'],
                              value!,
                            );
                            setState(() {});
                          },
                        ),
                        title: update[index]!
                            ? TextField(
                                controller: itemNameControllers[index],
                              )
                            : Text(
                                // 'item $index',
                                itemsList[index].value['name'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                        subtitle: update[index]!
                            ? TextField(
                                controller: itemDescriptionControllers[index],
                              )
                            : Text(
                                // 'description $index',
                                itemsList[index].value['description'],
                                style: const TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                        trailing: update[index]!
                            ? IconButton(
                                onPressed: () {
                                  updateItem(
                                    itemsList[index].value['id'],
                                    args.id,
                                    itemNameControllers[index]!.text,
                                    itemDescriptionControllers[index]!.text,
                                    completed[index] ?? false,
                                  );
                                  setState(() {
                                    update[index] = false;
                                  });
                                },
                                icon: Icon(
                                  Icons.save,
                                  color: Colors.purple[200],
                                ),
                              )
                            : IconButton(
                                onPressed: () {
                                  setState(() {
                                    update[index] = true;
                                    itemNameControllers[index]!.text =
                                        itemsList[index].value['name'];
                                    itemDescriptionControllers[index]!.text =
                                        itemsList[index].value['description'];
                                  });
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.purple[200],
                                ),
                              ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'No items available yet.',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  // const SizedBox(
                  //   height: 20,
                  //   width: double.infinity,
                  // ),
                  // addNewItemButton(),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                  ),
                ],
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class ViewArguments {
  final String listName;
  final String id;
  final bool? all;

  const ViewArguments({
    required this.listName,
    required this.id,
    this.all,
  });
}

// Widget addNewItemButton() {
//   return ElevatedButton.icon(
//     onPressed: () {
//       showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             icon: const CircleAvatar(
//               radius: 30,
//               child: Icon(
//                 Icons.add,
//                 size: 30,
//               ),
//             ),
//             content: Form(
//               key: _formKey,
//               child: TextFormField(
//                 controller: nameController,
//                 decoration: const InputDecoration(
//                   hintText: 'Add name',
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a new list';
//                   }
//                   return null;
//                 },
//               ),
//             ),
//             actions: [
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     createList(nameController.text);
//                     nameController.clear();
//                     Navigator.pop(context);
//                     setState(() {});
//                   }
//                 },
//                 child: const Text('Add'),
//               ),
//             ],
//           );
//         },
//       );
//     },
//     icon: const Icon(Icons.add),
//     label: const Text('Add new list'),
//   );
// }
