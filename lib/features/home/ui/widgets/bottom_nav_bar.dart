import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class MyBottomNavBar extends StatelessWidget {
  const MyBottomNavBar({super.key, required this.currentIndex, required this.onTap});

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        backgroundColor: AppColors.kPrimary,
        selectedItemColor: AppColors.kOnPrimary,
        unselectedItemColor: AppColors.kOnPrimary.withAlpha(60),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      );
  }
}
