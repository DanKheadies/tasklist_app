// import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:tasklist_app/bottom_nav_bar.dart';
import 'package:tasklist_app/func.dart';
import 'package:tasklist_app/view_list_screen.dart';
// import 'package:status_alert/status_alert.dart';

class ListsScreen extends StatefulWidget {
  const ListsScreen({super.key});

  @override
  State<ListsScreen> createState() => _ListsScreenState();
}

class _ListsScreenState extends State<ListsScreen> with Func {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'My Lists',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              // Navigate to Settings screen
            },
            icon: const Icon(Icons.settings),
          ),
          IconButton(
            onPressed: () {
              // View all items
              Navigator.pushNamed(
                context,
                ViewListScreen.routeName,
                arguments: const ViewArguments(
                  listName: 'All Items',
                  id: '',
                  all: true,
                ),
              );
            },
            icon: const Icon(Icons.more_horiz),
          ),
        ],
      ),
      // bottomNavigationBar: bottNavBar(),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 0),
      body: FutureBuilder(
        future: getLists(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isNotEmpty) {
              return ListView.builder(
                itemCount: snapshot.data!.length + 1,
                itemBuilder: (context, index) {
                  List entryList = snapshot.data!.entries.toList();

                  if (index == snapshot.data!.length) {
                    // return ElevatedButton.icon(
                    //   onPressed: () {},
                    //   icon: const Icon(Icons.add),
                    //   label: const Text('Add list'),
                    // );
                    return addNewListButton();
                  } else {
                    return Card(
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            ViewListScreen.routeName,
                            arguments: ViewArguments(
                              listName: entryList[index].value['name'] ?? '',
                              id: entryList[index].value['id'] ?? '',
                            ),
                          );
                        },
                        leading: const Icon(Icons.list),
                        title: Text(entryList[index].value['name'] ?? ''),
                        trailing: const Icon(Icons.arrow_right),
                      ),
                    );
                  }
                },
              );
            } else {
              // return Center(
              //   child: EmptyWidget(
              //     image: null,
              //     packageImage: PackageImage.Image_4,
              //     title: 'No Lists',
              //     subTitle: 'No Lists available yet',
              //     titleTextStyle: const TextStyle(
              //       fontSize: 22,
              //       color: Colors.deepPurple,
              //       fontWeight: FontWeight.w500,
              //     ),
              //     subtitleTextStyle: const TextStyle(
              //       fontSize: 14,
              //       color: Colors.grey,
              //     ),
              //   ),
              // );
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'No lists available yet.',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                    width: double.infinity,
                  ),
                  addNewListButton(),
                  const SizedBox(
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

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });

  //   if (_selectedIndex == 1) {
  //     Navigator.of(context).pushNamed('/recipes');
  //   } else if (_selectedIndex == 2) {
  //     Navigator.of(context).pushNamed('/file-upload');
  //   } else if (_selectedIndex == 3) {
  //     Navigator.of(context).pushNamed('/chat-room');
  //   }
  // }

  // BottomNavigationBar bottNavBar() {
  //   return BottomNavigationBar(
  //     currentIndex: _selectedIndex,
  //     selectedItemColor: Colors.purple[200],
  //     unselectedItemColor: Colors.black,
  //     showUnselectedLabels: true,
  //     unselectedLabelStyle: const TextStyle(
  //       color: Colors.black,
  //       fontSize: 11,
  //     ),
  //     unselectedIconTheme: const IconThemeData(
  //       size: 15,
  //     ),
  //     onTap: _onItemTapped,
  //     items: const [
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.home),
  //         label: 'Home',
  //       ),
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.restaurant),
  //         label: 'Recipes',
  //       ),
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.file_download_sharp),
  //         label: 'Files',
  //       ),
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.chat_bubble),
  //         label: 'Chat',
  //       ),
  //     ],
  //   );
  // }

  Widget addNewListButton() {
    return ElevatedButton.icon(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              icon: const CircleAvatar(
                radius: 30,
                child: Icon(
                  Icons.add,
                  size: 30,
                ),
              ),
              content: Form(
                key: _formKey,
                child: TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    hintText: 'Add name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a new list';
                    }
                    return null;
                  },
                ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      createList(nameController.text);
                      nameController.clear();
                      Navigator.pop(context);
                      setState(() {});
                    }
                  },
                  child: const Text('Add'),
                ),
              ],
            );
          },
        );
      },
      icon: const Icon(Icons.add),
      label: const Text('Add new list'),
    );
  }
}
