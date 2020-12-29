import 'package:flutter/material.dart';
import 'package:places/ui/res/svg_icons/svg_icon.dart';
import 'package:places/ui/res/svg_icons/svg_icons.dart';

/// Шаблон для будущего BottomNavigationBar
class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedFontSize: 0,
      unselectedFontSize: 0,
      // ignore: prefer_const_literals_to_create_immutables
      items: [
        const BottomNavigationBarItem(
          icon: SvgIcon(icon: SvgIcons.list),
          activeIcon: SvgIcon(icon: SvgIcons.listFill),
          label: '',
        ),
        const BottomNavigationBarItem(
          icon: SvgIcon(icon: SvgIcons.map),
          activeIcon: SvgIcon(icon: SvgIcons.mapFill),
          label: '',
        ),
        const BottomNavigationBarItem(
          icon: SvgIcon(icon: SvgIcons.heart),
          activeIcon: SvgIcon(icon: SvgIcons.heartFill),
          label: '',
        ),
        const BottomNavigationBarItem(
          icon: SvgIcon(icon: SvgIcons.settings),
          activeIcon: SvgIcon(icon: SvgIcons.settingsFill),
          label: '',
        ),
      ],
    );
  }
}
