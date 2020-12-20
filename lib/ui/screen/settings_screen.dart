import 'package:flutter/material.dart';
import 'package:places/main.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/widgets/custom_bottom_nav_bar.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.settingsAppbarTitle),
      ),
      bottomNavigationBar: CustomBottomNavBar(),
      body: Column(
        children: [
          SwitchListTile(
            title: Text(AppStrings.settingsDarkTheme),
            value: themeState.isDark,
            onChanged: _onChangeTheme,
          ),
          ListTile(
            title: Text(AppStrings.settingsTutorial),
            trailing: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Icon(
                Icons.info_outline,
                color: Theme.of(context).accentColor,
              ),
            ),
            onTap: () {
              print('Show tutorial');
            },
          ),
        ],
      ),
    );
  }

  void _onChangeTheme(bool newValue) => themeState.isDark = newValue;
}
