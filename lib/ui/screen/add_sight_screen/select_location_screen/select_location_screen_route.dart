import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/interactor/theme_interactor.dart';
import 'package:places/model/location/performers.dart';
import 'package:places/model/repository/location_repository.dart';
import 'package:places/model/theme/performers.dart';
import 'package:places/ui/screen/add_sight_screen/select_location_screen/select_location_screen.dart';
import 'package:places/ui/screen/add_sight_screen/select_location_screen/select_location_wm.dart';
import 'package:provider/provider.dart';

class SelectLocationScreenRoute extends MaterialPageRoute {
  SelectLocationScreenRoute()
      : super(
          builder: (context) =>
              const SelectLocationScreen(wmBuilder: _wmBuilder),
        );
}

// Билдер для WidgetModel
WidgetModel _wmBuilder(BuildContext context) {
  return SelectLocationWm(
    context.read<WidgetModelDependencies>(),
    Model([
      GetDarkModePerformer(context.read<ThemeInteractor>()),
      GetLastKnownLocationPerformer(context.read<LocationRepository>()),
    ]),
    Navigator.of(context),
  );
}
