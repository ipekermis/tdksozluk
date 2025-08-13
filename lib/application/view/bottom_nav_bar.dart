import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int ind;

  const BottomNavBar({super.key, required this.ind});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Color(0xFFCC2041),
      unselectedItemColor: Colors.grey,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      currentIndex: ind,
      onTap: (index) {
        // Navigasyon işlemleri
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Anasayfa',
          backgroundColor: Colors.white,
        ),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Ara'),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark_border),
          label: 'Kayıtlı',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Geçmiş'),
      ],
    );
  }
}
