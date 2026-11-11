
import 'package:flutter/material.dart';

class AppBottomNavigation extends StatelessWidget {
  final int selectedIndex;

  const AppBottomNavigation({
    super.key,
    required this.selectedIndex,
  });

  void navigate(BuildContext context, int index) {
    if (index == selectedIndex) {
      return;
    }

    final List<String> routes = [
      '/home',
      '/booking',
      '/profile',
    ];

    Navigator.pushReplacementNamed(
      context,
      routes[index],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: (index) {
        navigate(context, index);
      },
      type: BottomNavigationBarType.fixed,
      selectedItemColor: const Color(0xFF176B43),
      unselectedItemColor: Colors.blueGrey,
      backgroundColor: Colors.white,
      elevation: 8,

      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_rounded),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark_rounded),
          label: 'Bookings',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_rounded),
          label: 'Profile',
        ),
      ],
    );
  }
}
