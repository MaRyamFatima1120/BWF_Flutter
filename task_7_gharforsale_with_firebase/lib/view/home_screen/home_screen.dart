import 'package:flutter/material.dart';
import 'package:task_7_gharforsale_with_firebase/view/home_screen/navigation_screens/book_marked_screen/bookmarked_screen.dart';
import 'package:task_7_gharforsale_with_firebase/view/home_screen/navigation_screens/profile_screen.dart';
import 'navigation_screens/navigation_home_screen/navigation_home_screen.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedItem = 0;

  void _onItemSelected(int index) {
    setState(() {
      _selectedItem = index;
    });
  }

  final List<Widget> _pages = [
    const NavigationHomeScreen(),
    const BookMarkedScreen(),
   const BottomProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedItem],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        // showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 30,
        elevation: 30,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),

          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_remove_outlined),
            label: "Favorite",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Profile",
          ),
        ],
        currentIndex: _selectedItem,
        onTap: _onItemSelected,
      ),
    );
  }
}

