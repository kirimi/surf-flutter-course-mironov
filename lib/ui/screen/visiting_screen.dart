import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/app_colors.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_text_styles.dart';
import 'package:places/ui/screen/sight_details_screen/sight_details_bottomsheet.dart';
import 'package:places/ui/widgets/custom_bottom_nav_bar.dart';
import 'package:places/ui/widgets/custom_tab_bar/custom_tab_bar.dart';
import 'package:places/ui/widgets/custom_tab_bar/custom_tab_bar_item.dart';
import 'package:places/ui/widgets/draggable_dismissible_sight_card.dart';
import 'package:places/ui/widgets/sight_list_widget.dart';

/// Экран Хочу посетить/Посещенные места
class VisitingScreen extends StatefulWidget {
  static const String routeName = 'VisitingScreen';

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
      bottomNavigationBar: const CustomBottomNavBar(index: 2),
      body: TabBarView(
        controller: _controller,
        children: [
          SightListWidget(
            padding: const EdgeInsets.all(16.0),
            children: _buildToVisitSightList(),
          ),
          SightListWidget(
            padding: const EdgeInsets.all(16.0),
            children: _buildVisitedSightList(),
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

  // Карточки "Хочу посетить"
  List<Widget> _buildToVisitSightList() {
    final List<Widget> res = [];
    for (final sight in _toVisitSights) {
      res.add(
        DraggableDismissibleSightCard(
          key: ObjectKey(sight),
          sight: sight,
          onTap: () => _onSightTap(sight),
          onCalendarTap: () => _onCalendarTap(sight),
          onDeleteTap: () => _onDismissedSight(
            sight: sight,
            sights: _toVisitSights,
          ),
          onSightDrop: (droppedSight) => _swapSights(
            target: sight,
            sight: droppedSight,
            sights: _toVisitSights,
          ),
          onDismissed: () => _onDismissedSight(
            sight: sight,
            sights: _toVisitSights,
          ),
        ),
      );
    }
    return res;
  }

  // Карточки посещенные
  // На карточке другие action-кнопки, поэтому для простоты разделил на 2 метода
  // _buildToVisitSightList и _buildVisitedSightList
  List<Widget> _buildVisitedSightList() {
    final List<Widget> res = [];
    for (final sight in _visitedSights) {
      res.add(
        DraggableDismissibleSightCard(
          key: ObjectKey(sight),
          sight: sight,
          onTap: () => _onSightTap(sight),
          onShareTap: () {},
          onDeleteTap: () => _onDismissedSight(
            sight: sight,
            sights: _visitedSights,
          ),
          onSightDrop: (droppedSight) => _swapSights(
            target: sight,
            sight: droppedSight,
            sights: _visitedSights,
          ),
          onDismissed: () => _onDismissedSight(
            sight: sight,
            sights: _visitedSights,
          ),
        ),
      );
    }
    return res;
  }

  // Меняем местами элементы списка
  // передаем сюда sights, чтобы определить с каким именно списком работаем
  // _toVisitSights или _visitedSights
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
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) {
          return SightDetailsBottomSheet(sight: sight);
        });
  }

  Future<void> _onCalendarTap(Sight sight) async {
    final now = DateTime.now();
    final DateTime date = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      // на 30 лет вперед
      lastDate: now.add(const Duration(days: 365 * 30)),
    );
    print('Выбрана дата посещения ${date.toString()}');
  }
}
