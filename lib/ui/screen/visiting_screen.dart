import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/app_colors.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_text_styles.dart';
import 'package:places/ui/screen/sight_card.dart';
import 'package:places/ui/widgets/custom_bottom_nav_bar.dart';
import 'package:places/ui/widgets/custom_tab_bar/custom_tab_bar.dart';
import 'package:places/ui/widgets/custom_tab_bar/custom_tab_bar_item.dart';
import 'package:places/ui/widgets/sight_list_widget.dart';

/// Экран Хочу посетить/Посещенные места
class VisitingScreen extends StatefulWidget {
  @override
  _VisitingScreenState createState() => _VisitingScreenState();
}

class _VisitingScreenState extends State<VisitingScreen> with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
    _controller.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.visitingAppBarTitle,
          style: AppTextStyles.visitingAppBarTitle,
        ),
        backgroundColor: AppColors.transparent,
        elevation: 0,
        bottom: CustomTabBar(
          controller: _controller,
          onTabTap: (index) => _controller.animateTo(index),
          items: [
            CustomTabBarItem(text: AppStrings.visitingWantToVisitTab),
            CustomTabBarItem(text: AppStrings.visitingVisitedTab),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(),
      body: TabBarView(
        controller: _controller,
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
    );
  }
}
