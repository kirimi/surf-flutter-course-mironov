import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/model/favorites/performers.dart';
import 'package:places/model/repository/favorites_repository.dart';
import 'package:places/model/repository/location_repository.dart';
import 'package:places/model/repository/sight_repository.dart';
import 'package:places/model/repository/visited_repository.dart';
import 'package:places/model/visited/performers.dart';
import 'package:places/ui/screen/visiting_screen/visiting_screen.dart';
import 'package:places/ui/screen/visiting_screen/visiting_wm.dart';
import 'package:provider/provider.dart';

class VisitingScreenRoute extends MaterialPageRoute {
  VisitingScreenRoute()
      : super(
          builder: (context) => const VisitingScreen(wmBuilder: _wmBuilder),
        );
}

// Билдер для WidgetModel
WidgetModel _wmBuilder(BuildContext context) {
  return VisitingWm(
    context.read<WidgetModelDependencies>(),
    Model([
      GetFavoriteSightsPerformer(
        sightRepository: context.read<SightRepository>(),
        favoritesRepository: context.read<FavoritesRepository>(),
        locationRepository: context.read<LocationRepository>(),
      ),
      RemoveFromFavoritePerformer(context.read<FavoritesRepository>()),
      GetVisitedSightsPerformer(
          sightRepository: context.read<SightRepository>(),
          visitedRepository: context.read<VisitedRepository>()),
      RemoveFromVisitedPerformer(context.read<VisitedRepository>()),
    ]),
    navigator: Navigator.of(context),
  );
}
