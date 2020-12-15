import 'package:flutter/material.dart';
import 'package:places/ui/res/app_colors.dart';

/// Шаблон для будущего BottomNavigationBar
class CustomBottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.grayBlue,
      unselectedItemColor: AppColors.grayBlue2,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: '',
        ),
      ],
    );
  }
}
