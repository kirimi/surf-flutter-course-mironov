import 'dart:math';

import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/domain/sight_type.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/screen/filters_screen/type_filter_item_widget.dart';
import 'package:places/ui/widgets/custom_bottom_nav_bar.dart';

/// Экран с фильтрами
class FiltersScreen extends StatefulWidget {
  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  static const double _minRange = 100.0;
  static const double _maxRange = 10000.0;

  // значения слайдера
  RangeValues _rangeValues;

  // текущее местоположение
  double _currentLat = 30.433278;
  double _currentLon = 59.685994;

  // список мест
  final List<Sight> _sights = mocks;

  // список категорий
  final List<SightType> _types = typeMocks;

  // Выбранные категории для фильтрации
  final List<String> _selectedTypes = [];

  // количество элементов, которые попадают под условие фильтра
  int _filteredCount;

  @override
  void initState() {
    super.initState();
    _initFilters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: _clearFilters,
            child: Text(AppStrings.filtersClear),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.filtersCategories,
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 24.0),
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _types.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.0,
                mainAxisSpacing: 20.0,
                crossAxisSpacing: 20.0,
              ),
              itemBuilder: (BuildContext context, int index) {
                return TypeFilterItemWidget(
                  sightType: _types[index],
                  isSelected: _isTypeSelected(_types[index].name),
                  onTap: () {
                    _onTypeSelect(_types[index].name);
                    _filteredCount = _calculateFilteredCount();
                  },
                );
              },
            ),
            SizedBox(height: 60.0),
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
                min: _minRange,
                max: _maxRange,
                onChangeEnd: (_) {
                  // считаем количество отфильтрованных элементов когда пользователь закончил изменения,
                  // чтобы не дергать будущий репозиторий при каждом движении слайдера
                  setState(() => _filteredCount = _calculateFilteredCount());
                },
                onChanged: (newValues) {
                  setState(() => _rangeValues = newValues);
                }),
            Expanded(child: Container()),
            ElevatedButton(
              onPressed: _onShowTap,
              child: Text(_getShowButtonLabel()),
            )
          ],
        ),
      ),
    );
  }

  // выдает строку диапазона расстояний для подсказки наверху слайдера.
  String _getDistanceLabel() {
    String distLabel(double distanceMeters) {
      if (distanceMeters >= 1000) {
        return '${(distanceMeters / 1000).toStringAsFixed(2)}${AppStrings.filtersDistanceKilometers}';
      }
      return '${(distanceMeters).toStringAsFixed(0)}${AppStrings.filtersDistanceMeters}';
    }

    return '${AppStrings.filtersFrom} ${distLabel(_rangeValues.start)} ${AppStrings.filtersTo} ${distLabel(_rangeValues.end)}';
  }

  // надпись на кнопке с количеством результатов по фильтру
  String _getShowButtonLabel() {
    return '${AppStrings.filtersShow.toUpperCase()} ($_filteredCount)';
  }

  // возвращает количество точек, которые попадают под условие фильтра
  // если тип места не выбран, то не применяем фильтр места, если хоть один тип выбран,
  // то фильтруем по типу
  int _calculateFilteredCount() {
    final filteredSights = _sights
        .where((sight) => _selectedTypes.isNotEmpty ? _selectedTypes.contains(sight.type) : true)
        .where(
          (sight) => _isPointInsideRange(
            sight.lat,
            sight.lon,
            _rangeValues.start,
            _rangeValues.end,
          ),
        )
        .toList();

    return filteredSights.length;
  }

  // сбрасывает фильтры в начальное значение
  void _clearFilters() {
    setState(() {
      _initFilters();
    });
  }

  // инициализирует начальное значение фильтров
  void _initFilters() {
    _rangeValues = RangeValues(_minRange, _maxRange);
    _selectedTypes.clear();
    _filteredCount = _calculateFilteredCount();
  }

  // При тапе на категорию добавляем или убираем ее в фильтре
  void _onTypeSelect(String typeName) {
    setState(() {
      _isTypeSelected(typeName) ? _selectedTypes.remove(typeName) : _selectedTypes.add(typeName);
    });
  }

  bool _isTypeSelected(String typeName) => _selectedTypes.contains(typeName);

  void _onShowTap() {
    print('minDistance: ${_rangeValues.start}\nmaxDistance: ${_rangeValues.end}\ntypes: $_selectedTypes');
    // todo возвращаем фильтр на страницу sight_list_screen.dart
  }

  // Возвращает лежит ли точка в радисе между minDistance и maxDistance от lat/lon
  // minDistance/maxDistance в метрах
  // todo перенести в отдельный файл utils или типа того, тесты
  bool _isPointInsideRange(double lat, double lon, double minDistance, double maxDistance) {
    final double ky = 40000000 / 360;
    final double kx = cos(pi * _currentLat / 180.0) * ky;
    final double dx = (_currentLon - lon).abs() * kx;
    final double dy = (_currentLat - lat).abs() * ky;
    final double dis = sqrt(dx * dx + dy * dy);
    return dis >= minDistance && dis <= maxDistance;
  }
}
