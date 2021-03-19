import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/ui/screen/map_screen/map_screen.dart';
import 'package:places/ui/screen/map_screen/map_wm.dart';
import 'package:provider/provider.dart';

class MapScreenRoute extends MaterialPageRoute {
  MapScreenRoute()
      : super(
          builder: (context) => const MapScreen(wmBuilder: _wmBuilder),
        );
}

// Билдер для WidgetModel
WidgetModel _wmBuilder(BuildContext context) {
  return MapWm(
    context.read<WidgetModelDependencies>(),
    Model([]),
    Navigator.of(context),
  );
}
