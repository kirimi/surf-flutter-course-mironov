import 'package:flutter/material.dart';

/// Репозиторий для хранения текущей темы приложения.
///
/// Текущая тема меняется параметром [ThemeState.isDark]
/// В [App] подписываемся на обновления и динамически меняем тему в MaterialApp.
/// Тема меняется в [SettingsScreen]
class ThemeState extends ChangeNotifier {
  bool _isDark = false;

  bool get isDark => _isDark;
  set isDark(bool newVal) {
    _isDark = newVal;
    notifyListeners();
  }
}
