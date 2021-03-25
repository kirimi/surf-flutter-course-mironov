import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/model/favorites/performers.dart';
import 'package:places/model/repository/favorites_repository.dart';
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
        favoritesRepository: context.read<FavoritesRepository>(),
      ),
      RemoveFromFavoritePerformer(context.read<FavoritesRepository>()),
      GetVisitedSightsPerformer(
          visitedRepository: context.read<VisitedRepository>()),
      RemoveFromVisitedPerformer(context.read<VisitedRepository>()),
    ]),
    navigator: Navigator.of(context),
  );
}
