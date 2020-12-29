import 'package:flutter/material.dart';
import 'package:places/config.dart';
import 'package:places/domain/filter.dart';
import 'package:places/domain/sight.dart';
import 'package:places/domain/sight_type.dart';
import 'package:places/domain/sight_types.dart';
import 'package:places/filter_utils.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/screen/filters_screen/widget/type_filter_item_widget.dart';
import 'package:places/ui/widgets/custom_bottom_nav_bar.dart';
import 'package:places/ui/widgets/icon_elevated_button.dart';

/// Экран с фильтрами
///
/// В конструкторе передается текущий фильтр
class FiltersScreen extends StatefulWidget {
  final Filter filter;

  const FiltersScreen({
    Key key,
    @required this.filter,
  })  : assert(filter != null),
        super(key: key);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  // список категорий
  final List<SightType> _types = defaultSightTypes;

  // список мест
  List<Sight> _sights;

  // Фильтр
  Filter _filter;

  // значения слайдера
  RangeValues _rangeValues;

  // количество элементов, которые попадают под условие фильтра
  int _filteredCount;

  @override
  void initState() {
    super.initState();
    _sights = mocks;
    _filter = widget.filter;
    _rangeValues = RangeValues(_filter.minDistance, _filter.maxDistance);
    _filteredCount = _calculateFilteredCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: _clearFilters,
            child: const Text(AppStrings.filtersClear),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
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
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _types.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 20.0,
                crossAxisSpacing: 20.0,
              ),
              itemBuilder: _buildFilterItem,
            ),
            const SizedBox(height: 60.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.filtersDistance,
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(_getDistanceLabel()),
              ],
            ),
            RangeSlider(
                values: _rangeValues,
                min: Config.minRange,
                max: Config.maxRange,
                onChangeEnd: (_) {
                  // считаем количество отфильтрованных элементов когда
                  // пользователь закончил изменения, чтобы не дергать будущий
                  // репозиторий при каждом движении слайдера
                  _filter.minDistance = _rangeValues.start;
                  _filter.maxDistance = _rangeValues.end;
                  setState(() {
                    _filteredCount = _calculateFilteredCount();
                  });
                },
                onChanged: (newValues) {
                  setState(() => _rangeValues = newValues);
                }),
            const Spacer(),
            IconElevatedButton(
              text: _getShowButtonLabel(),
              onPressed: _onShowTap,
            ),
          ],
        ),
      ),
    );
  }

  // Элемент фильтра
  Widget _buildFilterItem(BuildContext context, int index) {
    return TypeFilterItemWidget(
      sightType: _types[index],
      isSelected: _isTypeSelected(_types[index]),
      onTap: () {
        _onTypeSelect(_types[index]);
        _filteredCount = _calculateFilteredCount();
      },
    );
  }

  // выдает строку диапазона расстояний для подсказки наверху слайдера.
  String _getDistanceLabel() {
    String distLabel(double distanceMeters) {
      if (distanceMeters >= 1000) {
        return '${(distanceMeters / 1000).toStringAsFixed(2)}${AppStrings.filtersDistanceKilometers}';
      }
      return '${distanceMeters.toStringAsFixed(0)}${AppStrings.filtersDistanceMeters}';
    }

    return '${AppStrings.filtersFrom} ${distLabel(_rangeValues.start)} ${AppStrings.filtersTo} ${distLabel(_rangeValues.end)}';
  }

  // надпись на кнопке с количеством результатов по фильтру
  String _getShowButtonLabel() {
    return '${AppStrings.filtersShow.toUpperCase()} ($_filteredCount)';
  }

  // возвращает количество точек, которые попадают под условие фильтра
  // если тип места не выбран, то не применяем фильтр места, если хоть один тип
  // выбран, то фильтруем по типу
  int _calculateFilteredCount() {
    final filteredSights = filteredSightList(_sights, _filter, currentPoint);
    return filteredSights.length;
  }

  // сбрасывает фильтры в начальное значение
  void _clearFilters() {
    _filter.minDistance = Config.minRange;
    _filter.maxDistance = Config.maxRange;
    _filter.types.clear();
    setState(() {
      _rangeValues = RangeValues(_filter.minDistance, _filter.maxDistance);
      _filteredCount = _calculateFilteredCount();
    });
  }

  // При тапе на категорию добавляем или убираем ее в фильтре
  void _onTypeSelect(SightType type) {
    setState(() {
      _isTypeSelected(type)
          ? _filter.types.remove(type)
          : _filter.types.add(type);
    });
  }

  bool _isTypeSelected(SightType type) => _filter.types.contains(type);

  void _onShowTap() {
    Navigator.of(context).pop(_filter);
  }
}
