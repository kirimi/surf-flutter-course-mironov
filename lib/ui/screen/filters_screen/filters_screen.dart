import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/domain/filter.dart';
import 'package:places/domain/sight_type/sight_type.dart';
import 'package:places/environment/environment.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/screen/filters_screen/filters_wm.dart';
import 'package:places/ui/screen/filters_screen/widget/type_filter_item_widget.dart';
import 'package:places/ui/widgets/custom_bottom_nav_bar.dart';
import 'package:places/ui/widgets/icon_elevated_button.dart';
import 'package:relation/relation.dart';

/// Экран с фильтрами
///
/// В конструкторе передается текущий фильтр
class FiltersScreen extends CoreMwwmWidget {
  static const String routeName = 'FiltersScreen';

  const FiltersScreen({
    @required WidgetModelBuilder wmBuilder,
    @required Filter filter,
  })  : assert(wmBuilder != null),
        assert(filter != null),
        super(widgetModelBuilder: wmBuilder);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends WidgetState<FiltersWm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: wm.clearFilter,
            child: const Text(AppStrings.filtersClear),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(index: 0),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.filtersCategories,
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 24.0),
            _buildTypeFilter(),
            const SizedBox(height: 60.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.filtersDistance,
                  style: Theme.of(context).textTheme.headline6,
                ),
                StreamedStateBuilder<RangeValues>(
                  streamedState: wm.rangeValues,
                  builder: (context, rangeValues) {
                    return Text(
                      _getDistanceLabel(rangeValues.start, rangeValues.end),
                    );
                  },
                ),
              ],
            ),
            StreamedStateBuilder<RangeValues>(
              streamedState: wm.rangeValues,
              builder: (context, rangeValues) {
                return RangeSlider(
                  values: rangeValues,
                  min: Environment.instance.buildConfig.minRange,
                  max: Environment.instance.buildConfig.maxRange,
                  onChangeEnd: (newValues) => wm.onFinishChangeRange(newValues),
                  onChanged: (newValues) => wm.onChangeRange(newValues),
                );
              },
            ),
            const Spacer(),
            StreamedStateBuilder<int>(
              streamedState: wm.filteredCount,
              builder: (context, count) {
                return IconElevatedButton(
                  text: '${AppStrings.filtersShow.toUpperCase()} ($count)',
                  onPressed: wm.onShow,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Фильтр категорий
  Widget _buildTypeFilter() {
    final bool isSmallScreen = MediaQuery.of(context).size.height < 800;

    return isSmallScreen
        ? SizedBox(
            height: 115,
            child: StreamedStateBuilder<List<SightType>>(
              streamedState: wm.selectedSightTypes,
              builder: (context, selectedTypes) {
                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: wm.sightTypes.length,
                  itemBuilder: (context, index) =>
                      _buildFilterItem(wm.sightTypes[index], selectedTypes),
                  separatorBuilder: (_, __) {
                    return const SizedBox(width: 32.0);
                  },
                );
              },
            ),
          )
        : StreamedStateBuilder<List<SightType>>(
            streamedState: wm.selectedSightTypes,
            builder: (context, selectedTypes) {
              return GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: wm.sightTypes.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 20.0,
                  crossAxisSpacing: 20.0,
                ),
                itemBuilder: (context, index) =>
                    _buildFilterItem(wm.sightTypes[index], selectedTypes),
              );
            },
          );
  }

  // Элемент фильтра
  Widget _buildFilterItem(SightType sightType, List<SightType> selectedTypes) {
    return TypeFilterItemWidget(
      sightType: sightType,
      isSelected: selectedTypes.map((e) => e.code).contains(sightType.code),
      onTap: () => wm.toggleSightType(sightType),
    );
  }

  // выдает строку диапазона расстояний для подсказки наверху слайдера.
  String _getDistanceLabel(double start, double end) {
    String distLabel(double distanceMeters) {
      if (distanceMeters >= 1000) {
        return '${(distanceMeters / 1000).toStringAsFixed(2)}${AppStrings.filtersDistanceKilometers}';
      }
      return '${distanceMeters.toStringAsFixed(0)}${AppStrings.filtersDistanceMeters}';
    }

    return '${AppStrings.filtersFrom} ${distLabel(start)} ${AppStrings.filtersTo} ${distLabel(end)}';
  }
}
