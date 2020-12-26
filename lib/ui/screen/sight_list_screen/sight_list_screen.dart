import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/screen/add_sight_screen/add_sight_screen.dart';
import 'package:places/ui/screen/sight_list_screen/widget/add_button.dart';
import 'package:places/ui/screen/sight_list_screen/widget/sight_list_app_bar.dart';
import 'package:places/ui/widgets/custom_bottom_nav_bar.dart';
import 'package:places/ui/widgets/sight_card.dart';
import 'package:places/ui/widgets/sight_list_widget.dart';

/// Экран со списком интересных мест
class SightListScreen extends StatefulWidget {
  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  List<Sight> _sights;

  @override
  void initState() {
    super.initState();
    _sights = mocks;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SightListAppBar(
        title: AppStrings.sightListAppBar,
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
    for (final sight in _sights) {
      result.add(SightCard(
        sight: sight,
        onTap: () {},
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
}
