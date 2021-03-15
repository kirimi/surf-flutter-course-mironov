import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/model/repository/storage_repository.dart';
import 'package:places/ui/res/const.dart';
import 'package:places/ui/screen/onboarding_screen/onboarding_screen.dart';
import 'package:places/ui/screen/sight_list_screen/sight_list_screen.dart';
import 'package:places/utils/app_ticker_provider.dart';

class SplashWm extends WidgetModel {
  SplashWm(
    WidgetModelDependencies baseDependencies, {
    @required this.navigator,
    @required this.storageRepository,
  })  : assert(navigator != null),
        assert(storageRepository != null),
        super(baseDependencies);

  final NavigatorState navigator;
  final StorageRepository storageRepository;

  /// Анимация вращения логотипа
  final AnimationController rotationAnimation = AnimationController(
    vsync: AppTickerProvider(),
    upperBound: pi * 2,
    duration: Const.duration2000,
  );

  @override
  void onLoad() {
    super.onLoad();
    rotationAnimation.repeat();
    _onLoad();
  }

  @override
  void dispose() {
    rotationAnimation.dispose();
    super.dispose();
  }

  Future<void> _onLoad() async {
    try {
      // Ждем пока проинициализируется приложение и пройдет 2 секунды
      await Future.wait(
        [
          _initApp(),
          Future.delayed(Const.duration2000),
        ],
        // в случае ошибки _initApp не ждем 2 сек, чтобы обработать.
        eagerError: true,
      );
    } catch (e) {
      // если _initApp закончился ошибкой,
      // то тут потенциально обработка
      print('Error: $e');
    }
    _goNext();
  }

  /// Инициализация приложения
  Future<void> _initApp() async {}

  /// Переход дальше в соответствии первый запуск или нет
  void _goNext() {
    navigator.pushReplacementNamed(
      storageRepository.isFirstRun
          ? OnboardingScreen.routeName
          : SightListScreen.routeName,
    );

    // сохраняем флаг, что это не первый запуск
    storageRepository.isFirstRun = false;
  }
}
