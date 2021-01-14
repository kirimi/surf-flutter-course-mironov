import 'package:flutter/material.dart';
import 'package:places/search_history_state.dart';
import 'package:places/theme_state.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/themes.dart';
import 'package:places/ui/screen/splash_screen.dart';

// Хранилище для текущей темы приложения
final themeState = ThemeState();

// Хранилище для истории поиска.
// Тут, пока не внедряли других решений
final searchHistoryState = SearchHistoryState();

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    themeState.addListener(_onThemeChange);
  }

  @override
  void dispose() {
    themeState.removeListener(_onThemeChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appTitle,
      theme: themeState.isDark ? darkTheme : lightTheme,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }

  void _onThemeChange() => setState(() {});
}
