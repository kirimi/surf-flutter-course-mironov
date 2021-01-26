import 'package:flutter/material.dart';
import 'package:places/config.dart';
import 'package:places/filter_utils.dart';
import 'package:places/mocks.dart';
import 'package:places/model/filter.dart';
import 'package:places/model/sight.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_text_styles.dart';
import 'package:places/ui/res/svg_icons/svg_icons.dart';
import 'package:places/ui/screen/add_sight_screen/add_sight_screen.dart';
import 'package:places/ui/screen/filters_screen/filters_screen.dart';
import 'package:places/ui/screen/sight_details_screen/sight_details_bottomsheet.dart';
import 'package:places/ui/screen/sight_list_screen/widget/add_button.dart';
import 'package:places/ui/screen/sight_search_screen/sight_search_screen.dart';
import 'package:places/ui/widgets/custom_bottom_nav_bar.dart';
import 'package:places/ui/widgets/search_bar.dart';
import 'package:places/ui/widgets/sight_card.dart';

/// Экран со списком интересных мест
class SightListScreen extends StatefulWidget {
  static const String routeName = 'SightListScreen';

  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  List<Sight> _sights;

  Filter _filter = Filter(
    minDistance: Config.minRange,
    maxDistance: Config.maxRange,
    types: [],
  );

  @override
  void initState() {
    super.initState();
    _sights = mocks;
  }

  @override
  Widget build(BuildContext context) {
    final sightListWidget =
        MediaQuery.of(context).orientation == Orientation.portrait
            ? SliverList(
                delegate: SliverChildListDelegate(_buildSightList()),
              )
            : SliverGrid(
                delegate: SliverChildListDelegate(_buildSightList()),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 4 / 2,
                ),
              );

    return Scaffold(
      bottomNavigationBar: const CustomBottomNavBar(index: 0),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AddButton(onPressed: _onAddPressed),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: SearchSliverPersistentHeaderDelegate(),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
              child: SearchBar(
                readOnly: true,
                onTap: _onSearchTap,
                onFilterTap: _onFilterTap,
              ),
            ),
          ),
          sightListWidget
        ],
      ),
    );
  }

  List<Widget> _buildSightList() {
    final List<Widget> result = [];
    final filteredSights = filteredSightList(_sights, _filter, currentPoint);
    for (final sight in filteredSights) {
      result.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: SightCard(
          sight: sight,
          onTap: () => _onCardTap(sight),
          actionsBuilder: (_) {
            return [
              // favorite btn
              SightCardActionButton(
                onTap: () {},
                icon: SvgIcons.heart,
              ),
            ];
          },
        ),
      ));
    }
    return result;
  }

  Future<void> _onAddPressed() async {
    await Navigator.of(context).pushNamed(
      AddSightScreen.routeName,
    );
    setState(() {
      _sights = mocks;
    });
  }

  void _onSearchTap() {
    Navigator.of(context).pushNamed(
      SightSearchScreen.routeName,
      arguments: _filter,
    );
  }

  Future<void> _onFilterTap() async {
    final newFilter = await Navigator.of(context).pushNamed(
      FiltersScreen.routeName,
      arguments: _filter,
    ) as Filter;

    if (newFilter != null) {
      // Обновляем в соответствии с новым фильтром
      setState(() {
        _filter = newFilter;
      });
    }
  }

  void _onCardTap(Sight sight) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) {
          return SightDetailsBottomSheet(sight: sight);
        });
  }
}

/// Заголовок страницы.  Меняет размер шрифта в соответствии с высотой.
/// Слова переносятся автоматически.
class SearchSliverPersistentHeaderDelegate
    extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final textSizeTween = Tween<double>(begin: 32, end: 18).chain(
      CurveTween(curve: Curves.easeOutCubic),
    );
    final progress = shrinkOffset / maxExtent;
    final fontSize = textSizeTween.transform(progress);

    return Container(
      color: Theme.of(context).backgroundColor,
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            // ограничиваем ширину в 300,
            // чтобы перенос слов при скролле был более адекватен
            width: 300,
            child: Text(
              AppStrings.sightListAppBar,
              style: AppTextStyles.appBarTitle.copyWith(
                fontSize: fontSize,
                height: 1.2,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 150;

  @override
  double get minExtent => 70;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
