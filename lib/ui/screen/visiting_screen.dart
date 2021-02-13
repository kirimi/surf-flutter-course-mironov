import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/interactor/favorites_interactor.dart';
import 'package:places/interactor/visiting_interactor.dart';
import 'package:places/ui/res/app_colors.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_text_styles.dart';
import 'package:places/ui/res/svg_icons/svg_icons.dart';
import 'package:places/ui/screen/sight_details_screen/sight_details_bottomsheet.dart';
import 'package:places/ui/widgets/custom_bottom_nav_bar.dart';
import 'package:places/ui/widgets/custom_tab_bar/custom_tab_bar.dart';
import 'package:places/ui/widgets/custom_tab_bar/custom_tab_bar_item.dart';
import 'package:places/ui/widgets/draggable_dismissible_sight_card.dart';
import 'package:places/ui/widgets/ios_date_picker.dart';
import 'package:places/ui/widgets/sight_card.dart';
import 'package:places/ui/widgets/sight_list_widget.dart';
import 'package:provider/provider.dart';

/// Экран Хочу посетить/Посещенные места
class VisitingScreen extends StatefulWidget {
  static const String routeName = 'VisitingScreen';

  @override
  _VisitingScreenState createState() => _VisitingScreenState();
}

class _VisitingScreenState extends State<VisitingScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
      // при смене таба инициируем обновление Favorites или Visited
      if (_tabController.index == 0) {
        context.read<FavoritesInteractor>().getFavoritesSights();
      } else if (_tabController.index == 1) {
        context.read<VisitedInteractor>().getVisitedSights();
      }
    });
    context.read<FavoritesInteractor>().getFavoritesSights();
    context.read<VisitedInteractor>().getVisitedSights();
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
          controller: _tabController,
          onTabTap: (index) => _tabController.animateTo(index),
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
        controller: _tabController,
        children: [
          StreamBuilder<List<Sight>>(
              stream: context.read<FavoritesInteractor>().favoritesListStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                return SightListWidget(
                  padding: const EdgeInsets.all(16.0),
                  children: _buildToVisitSightList(snapshot.data),
                );
              }),
          StreamBuilder<List<Sight>>(
              stream: context.read<VisitedInteractor>().visitedStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                return SightListWidget(
                  padding: const EdgeInsets.all(16.0),
                  children: _buildVisitedSightList(snapshot.data),
                );
              }),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Карточки "Хочу посетить"
  List<Widget> _buildToVisitSightList(List<Sight> sights) {
    final List<Widget> res = [];
    for (var i = 0; i < sights.length; i++) {
      res.add(
        DraggableDismissibleSightCard(
          key: ValueKey(sights[i].id),
          sight: sights[i],
          onTap: () => _onSightTap(sights[i]),
          actionsBuilder: (_) => [
            // calendar btn
            SightCardActionButton(
              onTap: () => _onCalendarTap(sights[i]),
              icon: SvgIcons.calendar,
            ),
            // delete btn
            SightCardActionButton(
              onTap: () => _onDeleteFromFavorites(sights[i]),
              icon: SvgIcons.delete,
            ),
          ],
          onSightDrop: (droppedSight) => _onSortFavorites(
            sight: droppedSight,
            target: sights[i],
          ),
          onDismissed: () => _onDeleteFromFavorites(sights[i]),
        ),
      );
    }
    return res;
  }

  // Карточки посещенные
  // На карточке другие action-кнопки, поэтому для простоты разделил на 2 метода
  // _buildToVisitSightList и _buildVisitedSightList
  List<Widget> _buildVisitedSightList(List<Sight> sights) {
    final List<Widget> res = [];
    for (var i = 0; i < sights.length; i++) {
      res.add(
        DraggableDismissibleSightCard(
          key: ValueKey(sights[i].id),
          sight: sights[i],
          onTap: () => _onSightTap(sights[i]),
          actionsBuilder: (_) => [
            // share btn
            SightCardActionButton(
              onTap: () {},
              icon: SvgIcons.share,
            ),
            // delete btn
            SightCardActionButton(
              onTap: () => _onDeleteFromVisited(sights[i]),
              icon: SvgIcons.delete,
            ),
          ],
          onSightDrop: (droppedSight) => _onSortVisited(
            sight: droppedSight,
            target: sights[i],
          ),
          onDismissed: () => _onDeleteFromVisited(sights[i]),
        ),
      );
    }
    return res;
  }

  // Удаляем место из Favorites
  void _onDeleteFromFavorites(Sight sight) {
    context.read<FavoritesInteractor>().removeFromFavorites(sight);
  }

  // todo добавить функцию хранения сортировки в FavoritesRepository
  // Сортируем место из Favorites. Наверх target помещается sight
  Future<void> _onSortFavorites({Sight sight, Sight target}) async {}

  // Удаляем место из Visited
  void _onDeleteFromVisited(Sight sight) {
    context.read<VisitedInteractor>().removeFromVisited(sight);
  }

  // todo добавить функцию хранения сортировки в VisitedRepository
  // Сортируем место из Visited. Наверх target помещается sight
  Future<void> _onSortVisited({Sight sight, Sight target}) async {}

  void _onSightTap(Sight sight) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) {
          return SightDetailsBottomSheet(sight: sight);
        });
  }

  Future<void> _onCalendarTap(Sight sight) async {
    final first = DateTime.now();
    // на 30 лет вперед
    final last = first.add(const Duration(days: 365 * 30));

    DateTime date;

    if (Platform.isAndroid) {
      date = await showDatePicker(
        context: context,
        initialDate: first,
        firstDate: first,
        lastDate: last,
      );
    } else if (Platform.isIOS) {
      date = await showIosDatePicker(
        context: context,
        initialDate: first,
        firstDate: first,
        lastDate: last,
      );
    }

    if (date != null) {
      print('Выбрана дата посещения ${date.toString()}');
    }
  }
}
