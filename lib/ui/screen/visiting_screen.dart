import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/app_colors.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_text_styles.dart';
import 'package:places/ui/screen/sight_details_screen.dart';
import 'package:places/ui/widgets/custom_bottom_nav_bar.dart';
import 'package:places/ui/widgets/custom_tab_bar/custom_tab_bar.dart';
import 'package:places/ui/widgets/custom_tab_bar/custom_tab_bar_item.dart';
import 'package:places/ui/widgets/draggable_dismissible_sight_card.dart';
import 'package:places/ui/widgets/sight_list_widget.dart';

/// Экран Хочу посетить/Посещенные места
class VisitingScreen extends StatefulWidget {
  @override
  _VisitingScreenState createState() => _VisitingScreenState();
}

class _VisitingScreenState extends State<VisitingScreen>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  // моки мест которые хотим посетить и посещенные
  final List<Sight> _toVisitSights = [mocks[0], mocks[1], mocks[2]];
  final List<Sight> _visitedSights = [mocks[3]];

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
          style: AppTextStyles.appBarTitle.copyWith(
            color: Theme.of(context).primaryColor,
          ),
        ),
        backgroundColor: AppColors.transparent,
        elevation: 0,
        bottom: CustomTabBar(
          controller: _controller,
          onTabTap: (index) => _controller.animateTo(index),
          items: [
            CustomTabBarItem(
              text: AppStrings.visitingWantToVisitTab,
              activeStyle:
                  AppTextStyles.visitingActiveTab.copyWith(color: Colors.white),
              style: AppTextStyles.visitingTab
                  .copyWith(color: Theme.of(context).disabledColor),
            ),
            CustomTabBarItem(
              text: AppStrings.visitingVisitedTab,
              activeStyle:
                  AppTextStyles.visitingActiveTab.copyWith(color: Colors.white),
              style: AppTextStyles.visitingTab
                  .copyWith(color: Theme.of(context).disabledColor),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
      body: TabBarView(
        controller: _controller,
        children: [
          SightListWidget(
            padding: const EdgeInsets.all(16.0),
            children: _buildSightList(_toVisitSights),
          ),
          SightListWidget(
            padding: const EdgeInsets.all(16.0),
            children: _buildSightList(_visitedSights),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Widget> _buildSightList(List<Sight> sights) {
    final List<Widget> res = [];
    for (final sight in sights) {
      res.add(
        DraggableDismissibleSightCard(
          sight: sight,
          onTap: () => _onSightTap(sight),
          onFavoriteTap: () {},
          onSightDrop: (droppedSight) => _swapSights(
            target: sight,
            sight: droppedSight,
            sights: sights,
          ),
          onDismissed: (dismissedSight) => _onDismissedSight(
            sight: dismissedSight,
            sights: sights,
          ),
        ),
      );
    }
    return res;
  }

  // Меняем местами элементы списка
  void _swapSights({Sight target, Sight sight, List<Sight> sights}) {
    final targetIndex = sights.indexOf(target);
    final sightIndex = sights.indexOf(sight);
    setState(() {
      sights[targetIndex] = sight;
      sights[sightIndex] = target;
    });
  }

  // удаляем место из списка
  void _onDismissedSight({Sight sight, List<Sight> sights}) {
    setState(() {
      sights.removeWhere((element) => element == sight);
    });
  }

  void _onSightTap(Sight sight) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SightDetailsScreen(
          sight: sight,
        ),
      ),
    );
  }
}
