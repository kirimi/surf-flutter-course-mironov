import 'package:flutter/material.dart';
import 'package:places/model/repository/storage_repository.dart';
import 'package:places/ui/res/themes.dart';

/// Интерактор настроек
class ThemeInteractor extends ChangeNotifier {
  ThemeInteractor(this.repository);

  final StorageRepository repository;

  /// Текущая тема приложения
  ThemeData get theme => repository.isDarkTheme ? darkTheme : lightTheme;

  /// флаг темной темы
  bool get isDark => repository.isDarkTheme;

  /// устанавливает темную тему
  set isDark(bool newVal) {
    repository.isDarkTheme = newVal;
    notifyListeners();
  }
}
