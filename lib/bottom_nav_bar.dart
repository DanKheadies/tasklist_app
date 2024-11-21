import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  final int selectedIndex;

  const BottomNavBar({
    super.key,
    required this.selectedIndex,
  });

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (widget.selectedIndex != index) {
      if (_selectedIndex == 1) {
        Navigator.of(context).pushNamed('/recipes');
      } else if (_selectedIndex == 2) {
        Navigator.of(context).pushNamed('/file-upload');
      } else if (_selectedIndex == 3) {
        Navigator.of(context).pushNamed('/chat-room');
      } else {
        Navigator.of(context).pushNamed('/lists');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.selectedIndex,
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
