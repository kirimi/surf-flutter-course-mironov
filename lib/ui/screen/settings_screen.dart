import 'package:flutter/material.dart';
import 'package:places/main.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/svg_icons/svg_icon.dart';
import 'package:places/ui/res/svg_icons/svg_icons.dart';
import 'package:places/ui/widgets/custom_bottom_nav_bar.dart';

/// Экран настроек
class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.settingsAppbarTitle),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
      body: Column(
        children: [
          SwitchListTile(
            title: const Text(AppStrings.settingsDarkTheme),
            value: themeState.isDark,
            onChanged: _onChangeTheme,
          ),
          ListTile(
            title: const Text(AppStrings.settingsTutorial),
            trailing: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: SvgIcon(
                icon: SvgIcons.info,
                color: Theme.of(context).accentColor,
              ),
            ),
            onTap: () {
              // print('Show tutorial');
            },
          ),
        ],
      ),
    );
  }

  // ignore: use_setters_to_change_properties
  void _onChangeTheme(bool newValue) => themeState.isDark = newValue;
}
