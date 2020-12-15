import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/themes.dart';
import 'package:places/ui/screen/sight_details_screen.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appTitle,
      theme: isDark ? darkTheme : lightTheme,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SightDetailsScreen(
          sight: mocks[0],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: Container(
          height: 40,
          width: 40,
          child: FloatingActionButton(
            child: Icon(isDark ? Icons.wb_sunny : Icons.nightlight_round),
            onPressed: () {
              setState(() {
                isDark = !isDark;
              });
            },
          ),
        ),
      ),
    );
  }
}
