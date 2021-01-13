import 'package:flutter/material.dart';
import 'package:places/config.dart';
import 'package:places/domain/filter.dart';
import 'package:places/domain/sight.dart';
import 'package:places/filter_utils.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_text_styles.dart';
import 'package:places/ui/screen/add_sight_screen/add_sight_screen.dart';
import 'package:places/ui/screen/filters_screen/filters_screen.dart';
import 'package:places/ui/screen/sight_details_screen/sight_details_screen.dart';
import 'package:places/ui/screen/sight_list_screen/widget/add_button.dart';
import 'package:places/ui/screen/sight_search_screen/sight_search_screen.dart';
import 'package:places/ui/widgets/custom_bottom_nav_bar.dart';
import 'package:places/ui/widgets/search_bar.dart';
import 'package:places/ui/widgets/sight_card.dart';

/// Экран со списком интересных мест
class SightListScreen extends StatefulWidget {
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
    return Scaffold(
      bottomNavigationBar: const CustomBottomNavBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AddButton(onPressed: _onAddPressed),
      body: CustomScrollView(
        slivers: [
          // *****
          // В макете figma заголовок в две строки в развернутом виде
          // и в одну строку в свернутом.
          // Постарался этим реализовать что-то похожее ))
          SliverPersistentHeader(
            pinned: true,
            delegate: SearchSliverPersistentHeaderDelegate(),
          ),

          // *****  Более красивый вариант, на мой взгляд.
          // Но не смог добиться тут переноса строки
          // SliverAppBar(
          //   pinned: true,
          //   expandedHeight: 150,
          //   backgroundColor: Theme.of(context).backgroundColor,
          //   flexibleSpace: FlexibleSpaceBar(
          //     title: Text(
          //       AppStrings.sightListAppBar,
          //       style: AppTextStyles.appBarTitle
          //           .copyWith(color: Theme.of(context).primaryColor),
          //     ),
          //   ),
          // ),

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
          SliverList(
            delegate: SliverChildListDelegate(_buildSightList()),
          ),
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
          onFavoriteTap: () {},
        ),
      ));
    }
    return result;
  }

  Future<void> _onAddPressed() async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => AddSightScreen()),
    );
    setState(() {
      _sights = mocks;
    });
  }

  void _onSearchTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SightSearchScreen(
          filter: _filter,
        ),
      ),
    );
  }

  Future<void> _onFilterTap() async {
    final Filter newFilter = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FiltersScreen(
          filter: _filter,
        ),
      ),
    );

    // Обновляем в соответствии с новым фильтром
    setState(() {
      _filter = newFilter;
    });
  }

  void _onCardTap(Sight sight) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SightDetailsScreen(
          sight: sight,
        ),
      ),
    );
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
