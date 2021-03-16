import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/model/repository/storage_repository.dart';
import 'package:places/ui/screen/splash_screen/splash_screen.dart';
import 'package:places/ui/screen/splash_screen/splash_wm.dart';
import 'package:provider/provider.dart';

class SplashScreenRoute extends MaterialPageRoute {
  SplashScreenRoute()
      : super(
          builder: (context) =>
              SplashScreen(wmBuilder: (context) => _wmBuilder(context)),
        );
}

// Билдер для WidgetModel
WidgetModel _wmBuilder(BuildContext context) {
  return SplashWm(
    context.read<WidgetModelDependencies>(),
    storageRepository: context.read<StorageRepository>(),
    navigator: Navigator.of(context),
  );
}
