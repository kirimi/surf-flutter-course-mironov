import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/res/app_colors.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_text_styles.dart';
import 'package:places/ui/res/svg_icons/svg_icons.dart';
import 'package:places/ui/screen/visiting_screen/visiting_wm.dart';
import 'package:places/ui/screen/visiting_screen/widget/visiting_tab_bar.dart';
import 'package:places/ui/widgets/center_message.dart';
import 'package:places/ui/widgets/custom_bottom_nav_bar.dart';
import 'package:places/ui/widgets/draggable_dismissible_sight_card.dart';
import 'package:places/ui/widgets/sight_card.dart';
import 'package:places/ui/widgets/sight_list_widget.dart';
import 'package:relation/relation.dart';

/// Экран Хочу посетить/Посещенные места
class VisitingScreen extends CoreMwwmWidget {
  static const String routeName = 'VisitingScreen';

  const VisitingScreen({@required WidgetModelBuilder wmBuilder})
      : assert(wmBuilder != null),
        super(widgetModelBuilder: wmBuilder);

  @override
  _VisitingScreenState createState() => _VisitingScreenState();
}

class _VisitingScreenState extends WidgetState<VisitingWm> {
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
        bottom: VisitingTabBar(
          controller: wm.tabController,
          onTap: wm.tabTap,
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(index: 2),
      body: TabBarView(
        controller: wm.tabController,
        children: [
          EntityStateBuilder<List<Sight>>(
            streamedState: wm.favoriteSights,
            child: (context, sights) {
              return SightListWidget(
                padding: const EdgeInsets.all(16.0),
                children: _buildFavoriteSights(sights),
              );
            },
            loadingBuilder: (context, _) {
              return const Center(child: CircularProgressIndicator());
            },
            errorBuilder: (context, _, e) {
              return _ErrorMessage(message: e.toString());
            },
          ),
          EntityStateBuilder<List<Sight>>(
            streamedState: wm.visitedSights,
            child: (context, sights) {
              return SightListWidget(
                padding: const EdgeInsets.all(16.0),
                children: _buildVisitedSights(sights),
              );
            },
            loadingBuilder: (context, _) {
              return const Center(child: CircularProgressIndicator());
            },
            errorBuilder: (context, _, e) {
              return _ErrorMessage(message: e.toString());
            },
          ),
        ],
      ),
    );
  }

  // Карточки "Избранное"
  List<Widget> _buildFavoriteSights(List<Sight> sights) {
    final List<Widget> res = [];
    for (var i = 0; i < sights.length; i++) {
      res.add(
        DraggableDismissibleSightCard(
          key: ValueKey(sights[i].id),
          sight: sights[i],
          onTap: () => wm.showDetails(sights[i]),
          actionsBuilder: (_) => [
            // calendar btn
            SightCardActionButton(
              onTap: () => wm.selectTimeToVisit(sights[i]),
              icon: SvgIcons.calendar,
            ),
            // delete btn
            SightCardActionButton(
              onTap: () => wm.removeFromFavorites(sights[i]),
              icon: SvgIcons.delete,
            ),
          ],
          onSightDrop: (droppedSight) {},
          onDismissed: () => wm.removeFromFavorites(sights[i]),
        ),
      );
    }
    return res;
  }

  // Карточки посещенные
  List<Widget> _buildVisitedSights(List<Sight> sights) {
    final List<Widget> res = [];
    for (var i = 0; i < sights.length; i++) {
      res.add(
        DraggableDismissibleSightCard(
          key: ValueKey(sights[i].id),
          sight: sights[i],
          onTap: () => wm.showDetails(sights[i]),
          actionsBuilder: (_) => [
            // share btn
            SightCardActionButton(
              onTap: () {},
              icon: SvgIcons.share,
            ),
            // delete btn
            SightCardActionButton(
              onTap: () => wm.removeFromVisited(sights[i]),
              icon: SvgIcons.delete,
            ),
          ],
          onSightDrop: (droppedSight) {},
          onDismissed: () => wm.removeFromVisited(sights[i]),
        ),
      );
    }
    return res;
  }
}

/// Виджет для показа сообщения об ошибке на экране VisitingScreen
class _ErrorMessage extends StatelessWidget {
  const _ErrorMessage({Key key, this.message}) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return CenterMessage(
      icon: SvgIcons.error,
      title: AppStrings.sightSearchErrorTitle,
      subtitle: '${AppStrings.sightSearchErrorSubtitle}\n\n$message',
    );
  }
}
