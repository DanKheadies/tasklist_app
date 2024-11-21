import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:tasklist_app/bottom_nav_bar.dart';
import 'package:tasklist_app/func.dart';

class FileUploadScreen extends StatefulWidget {
  const FileUploadScreen({super.key});

  @override
  State<FileUploadScreen> createState() => _FileUploadScreenState();
}

class _FileUploadScreenState extends State<FileUploadScreen> with Func {
  int _selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'File Upload',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      // bottomNavigationBar: bottNavBar(),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 2),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.upload_file),
                  onPressed: () async {
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles();
                    print(result?.files.single.path);
                    if (result != null) {
                      File file = File(result.files.single.path!);

                      fileUpload(file);
                    } else {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context)
                          ..clearSnackBars()
                          ..showSnackBar(
                            const SnackBar(
                              content: Text('Upload canceled.'),
                            ),
                          );
                      }
                    }
                  },
                  label: const Text(
                    'Click to upload file',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const Text(
                'My Files',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Card(
                child: ListTile(
                  leading: Icon(Icons.file_copy),
                  title: Text('file name'),
                  trailing: Icon(Icons.arrow_right_alt_outlined),
                ),
              ),
              const Card(
                child: ListTile(
                  leading: Icon(Icons.file_copy),
                  title: Text('file name'),
                  trailing: Icon(Icons.arrow_right_alt_outlined),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (_selectedIndex == 0) {
      Navigator.of(context).pushNamed('/lists');
    } else if (_selectedIndex == 1) {
      Navigator.of(context).pushNamed('/recipes');
    } else {
      Navigator.of(context).pushNamed('/chat-room');
    }
  }

  BottomNavigationBar bottNavBar() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.purple[200],
      unselectedItemColor: Colors.black,
      showUnselectedLabels: true,
      unselectedLabelStyle: const TextStyle(
        color: Colors.black,
        fontSize: 11,
      ),
      unselectedIconTheme: const IconThemeData(
        size: 15,
      ),
      onTap: _onItemTapped,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.restaurant),
          label: 'Recipes',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.file_download_sharp),
          label: 'Files',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_bubble),
          label: 'Chat',
        ),
      ],
    );
  }
}
