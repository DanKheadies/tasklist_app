import 'package:flutter/material.dart';
import 'package:tasklist_app/bottom_nav_bar.dart';
import 'package:tasklist_app/func.dart';

class RecipesScreen extends StatefulWidget {
  const RecipesScreen({super.key});

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> with Func {
  // int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Recipes',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back_ios),
        //   onPressed: () {
        //     Navigator.of(context)
        //         .pushNamed('/lists')
        //         .then((value) => setState(() {}));
        //   },
        // ),
        automaticallyImplyLeading: false,
      ),
      // bottomNavigationBar: bottNavBar(),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 1),
      body: FutureBuilder(
        future: getRandomAPI(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isNotEmpty) {
              Map<String, dynamic> meal =
                  snapshot.data!.entries.toList().first.value[0];
              // print(meal);
              // print(meal['idMeal']);
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 300,
                        width: double.infinity,
                        child: Image.network(
                          meal['strMealThumb'],
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Placeholder(
                              fallbackHeight: 300,
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          meal['strMeal'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(meal['strInstructions']),
                    ],
                  ),
                ),
              );
            } else {
              return const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'No recipes available.',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
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

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });

  //   if (_selectedIndex == 0) {
  //     Navigator.of(context).pushNamed('/lists');
  //   } else if (_selectedIndex == 2) {
  //     Navigator.of(context).pushNamed('/file-upload');
  //   } else {
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
}
