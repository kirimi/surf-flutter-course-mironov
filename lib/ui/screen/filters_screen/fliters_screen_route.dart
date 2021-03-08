import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/domain/filter.dart';
import 'package:places/interactor/repository/location_repository.dart';
import 'package:places/interactor/repository/sight_repository.dart';
import 'package:places/model/sights/performers.dart';
import 'package:places/ui/screen/filters_screen/filters_screen.dart';
import 'package:places/ui/screen/filters_screen/filters_wm.dart';
import 'package:provider/provider.dart';

class FiltersScreenRoute extends MaterialPageRoute {
  FiltersScreenRoute({@required Filter filter})
      : super(
          builder: (context) => FiltersScreen(
            wmBuilder: (context) => _wmBuilder(context, filter),
            filter: filter,
          ),
        );
}

// Билдер для WidgetModel
WidgetModel _wmBuilder(BuildContext context, Filter filter) {
  return FiltersWm(
    context.read<WidgetModelDependencies>(),
    Model([
      GetSightsPerformer(
        sightRepository: context.read<SightRepository>(),
        locationRepository: context.read<LocationRepository>(),
      ),
    ]),
    navigator: Navigator.of(context),
    filter: filter,
  );
}
