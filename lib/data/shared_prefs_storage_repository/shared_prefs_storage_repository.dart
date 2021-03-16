import 'dart:convert';

import 'package:places/domain/filter.dart';
import 'package:places/model/repository/storage_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Хранилище настроек приложения в SharedPreference
class SharedPrefsStorageRepository implements StorageRepository {
  static SharedPrefsStorageRepository _instance;
  static SharedPreferences _pref;

  static Future<SharedPrefsStorageRepository> getInstance() async {
    _instance ??= SharedPrefsStorageRepository();
    _pref ??= await SharedPreferences.getInstance();
    return _instance;
  }

  static const String isDarkThemeKey = 'isDarkTheme';
  static const String filterKey = 'filter';
  static const String isFirstRunKey = 'isFirstRun';

  /// Темная тема
  @override
  bool get isDarkTheme => _pref.getBool(isDarkThemeKey) ?? false;

  @override
  set isDarkTheme(bool value) => _pref.setBool(isDarkThemeKey, value);

  /// Первый запуск
  @override
  bool get isFirstRun => _pref.getBool(isFirstRunKey) ?? true;

  @override
  set isFirstRun(bool value) => _pref.setBool(isFirstRunKey, value);

  /// настройки фильтра
  @override
  Filter get filter {
    final filterString = _pref.getString(filterKey);
    if (filterString == null) {
      return Filter.initial();
    }
    final filterMap =
        jsonDecode(_pref.getString(filterKey)) as Map<String, dynamic>;
    print(filterMap);
    return Filter.fromJson(filterMap);
  }

  @override
  set filter(Filter value) {
    final filterMap = jsonEncode(value.toJson());
    print(filterMap);
    _pref.setString(filterKey, filterMap);
  }
}
