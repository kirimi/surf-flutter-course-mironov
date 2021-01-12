import 'package:flutter/material.dart';
import 'package:places/config.dart';
import 'package:places/domain/filter.dart';
import 'package:places/domain/sight.dart';
import 'package:places/filter_utils.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/screen/add_sight_screen/add_sight_screen.dart';
import 'package:places/ui/screen/filters_screen/filters_screen.dart';
import 'package:places/ui/screen/sight_details_screen/sight_details_screen.dart';
import 'package:places/ui/screen/sight_list_screen/widget/add_button.dart';
import 'package:places/ui/screen/sight_search_screen/sight_search_screen.dart';
import 'package:places/ui/widgets/custom_bottom_nav_bar.dart';
import 'package:places/ui/widgets/search_bar.dart';
import 'package:places/ui/widgets/sight_card.dart';
import 'package:places/ui/widgets/sight_list_widget.dart';

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
      appBar: AppBar(
        title: const Text(AppStrings.sightListAppBar),
        bottom: SearchBar(
          readOnly: true,
          onTap: _onSearchTap,
          onFilterTap: _onFilterTap,
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AddButton(
        onPressed: _onAddPressed,
      ),
      body: SightListWidget(
        children: _buildSightList(),
      ),
    );
  }

  List<Widget> _buildSightList() {
    final List<Widget> result = [];
    final filteredSights = filteredSightList(_sights, _filter, currentPoint);
    for (final sight in filteredSights) {
      result.add(SightCard(
        sight: sight,
        onTap: () {
          _onCardTap(sight);
        },
        onFavoriteTap: () {},
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
