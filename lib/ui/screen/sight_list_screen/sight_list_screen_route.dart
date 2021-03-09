import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/model/favorites/model.dart';
import 'package:places/ui/screen/sight_list_screen/sight_list_screen.dart';
import 'package:places/ui/screen/sight_list_screen/sight_list_wm.dart';
import 'package:provider/provider.dart';

class SightListScreenRoute extends MaterialPageRoute {
  SightListScreenRoute()
      : super(
          builder: (context) => const SightListScreen(wmBuilder: _wmBuilder),
        );
}

// Билдер для WidgetModel
WidgetModel _wmBuilder(BuildContext context) {
  return SightListWm(
    context.read<WidgetModelDependencies>(),
    context.read<FavoritesModel>(),
    Navigator.of(context),
  );
}
