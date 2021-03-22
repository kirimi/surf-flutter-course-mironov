import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/interactor/theme_interactor.dart';
import 'package:places/model/favorites/performers.dart';
import 'package:places/model/filter/performers.dart';
import 'package:places/model/location/performers.dart';
import 'package:places/model/repository/location_repository.dart';
import 'package:places/model/repository/sight_repository.dart';
import 'package:places/model/repository/storage_repository.dart';
import 'package:places/model/sights/performers.dart';
import 'package:places/model/theme/performers.dart';
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
    Model([
      GetCurrentLocationPerformer(context.read<LocationRepository>()),
      GetLastKnownLocationPerformer(context.read<LocationRepository>()),
      GetDarkModePerformer(context.read<ThemeInteractor>()),
      GetSightsPerformer(
        sightRepository: context.read<SightRepository>(),
        locationRepository: context.read<LocationRepository>(),
      ),
      context.read<ToggleFavoritePerformer>(),
      SaveFilterPerformer(context.read<StorageRepository>()),
      GetFilterPerformer(context.read<StorageRepository>()),
    ]),
    Navigator.of(context),
  );
}
