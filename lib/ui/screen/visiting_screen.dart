import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/screen/sight_card.dart';
import 'package:places/ui/widgets/sight_list_widget.dart';

/// Экран Хочу посетить/Посещенные места
class VisitingScreen extends StatefulWidget {
  @override
  _VisitingScreenState createState() => _VisitingScreenState();
}

class _VisitingScreenState extends State<VisitingScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.visitingAppBarTitle),
          bottom: TabBar(
            tabs: [
              Text(AppStrings.visitingWantToVisitTab),
              Text(AppStrings.visitingVisitedTab),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SightListWidget(
              padding: const EdgeInsets.all(16.0),
              children: [
                SightCard(sight: mocks[1]),
                SightCard(sight: mocks[2]),
                SightCard(sight: mocks[0]),
              ],
            ),
            SightListWidget(
              padding: const EdgeInsets.all(16.0),
              children: [
                SightCard(sight: mocks[3]),
                SightCard(sight: mocks[4]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
