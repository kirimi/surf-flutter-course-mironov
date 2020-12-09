import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_text_styles.dart';
import 'package:places/ui/screen/sight_card.dart';

/// Экран со списком интересных мест
class SightListScreen extends StatefulWidget {
  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _MyAppBar(
        title: AppStrings.sightListAppBar,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              SightCard(sight: mocks[0]),
              SizedBox(height: 16.0),
              SightCard(sight: mocks[1]),
              SizedBox(height: 16.0),
              SightCard(sight: mocks[2]),
              SizedBox(height: 16.0),
              SightCard(sight: mocks[3]),
              SizedBox(height: 16.0),
              SightCard(sight: mocks[4]),
            ],
          ),
        ),
      ),
    );
  }
}

class _MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const _MyAppBar({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 64.0, right: 16.0, bottom: 16.0),
      child: Text(
        title,
        textAlign: TextAlign.left,
        maxLines: 2,
        style: AppTextStyles.sightListAppBar,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(150.0);
}
