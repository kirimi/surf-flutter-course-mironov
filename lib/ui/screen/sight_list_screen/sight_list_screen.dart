import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/svg_icons/svg_icons.dart';
import 'package:places/ui/screen/sight_list_screen/sight_list_wm.dart';
import 'package:places/ui/screen/sight_list_screen/widget/add_button.dart';
import 'package:places/ui/screen/sight_list_screen/widget/favorite_button/favorite_button.dart';
import 'package:places/ui/screen/sight_list_screen/widget/search_sliver_delegate.dart';
import 'package:places/ui/widgets/center_message.dart';
import 'package:places/ui/widgets/custom_bottom_nav_bar.dart';
import 'package:places/ui/widgets/search_bar.dart';
import 'package:places/ui/widgets/sight_card.dart';
import 'package:relation/relation.dart';

/// Экран со списком интересных мест
class SightListScreen extends CoreMwwmWidget {
  static const String routeName = 'SightListScreen';

  const SightListScreen({@required WidgetModelBuilder wmBuilder})
      : assert(wmBuilder != null),
        super(widgetModelBuilder: wmBuilder);

  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends WidgetState<SightListWm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomBottomNavBar(index: 0),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AddButton(onPressed: wm.onAddSight),
      body: EntityStateBuilder(
        streamedState: wm.sights,
        child: (context, List<Sight> sights) {
          return CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: SearchSliverPersistentHeaderDelegate(),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
                  child: SearchBar(
                    readOnly: true,
                    onTap: wm.onSearch,
                    onFilterTap: wm.onSelectFilter,
                  ),
                ),
              ),
              _buildSightListWidget(sights),
            ],
          );
        },
        loadingBuilder: (context, _) {
          return const Center(child: CircularProgressIndicator());
        },
        errorBuilder: (context, _, e) {
          return CenterMessage(
            icon: SvgIcons.error,
            title: AppStrings.sightSearchErrorTitle,
            subtitle: '${AppStrings.sightSearchErrorSubtitle}\n\n$e',
          );
        },
      ),
    );
  }

  Widget _buildSightListWidget(List<Sight> sights) {
    final List<Widget> sightCardsList = [];
    for (final sight in sights) {
      sightCardsList.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: SightCard(
          sight: sight,
          onTap: () => wm.showDetails(sight),
          actionsBuilder: (_) {
            return [
              FavoriteButton(sight),
            ];
          },
        ),
      ));
    }

    return MediaQuery.of(context).orientation == Orientation.portrait
        ? SliverList(
            delegate: SliverChildListDelegate(sightCardsList),
          )
        : SliverGrid(
            delegate: SliverChildListDelegate(sightCardsList),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 4 / 2,
            ),
          );
  }
}
