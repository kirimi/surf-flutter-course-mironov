import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/data/search_history_repository/search_history_repository.dart';
import 'package:places/domain/filter.dart';
import 'package:places/model/repository/location_repository.dart';
import 'package:places/model/repository/sight_repository.dart';
import 'package:places/model/search_history/performers.dart';
import 'package:places/model/sights/performers.dart';
import 'package:places/ui/screen/sight_search_screen/sight_search_screen.dart';
import 'package:places/ui/screen/sight_search_screen/sight_search_wm.dart';
import 'package:provider/provider.dart';

class SightSearchScreenRoute extends MaterialPageRoute {
  SightSearchScreenRoute({@required Filter filter})
      : assert(filter != null),
        super(
          builder: (context) => SightSearchScreen(
            wmBuilder: (context) => _wmBuilder(context, filter),
          ),
        );
}

// Билдер для WidgetModel
WidgetModel _wmBuilder(BuildContext context, Filter filter) {
  return SightSearchWm(
    context.read<WidgetModelDependencies>(),
    Model([
      GetSightsPerformer(
          sightRepository: context.read<SightRepository>(),
          locationRepository: context.read<LocationRepository>()),
      AddToHistoryPerformer(context.read<SearchHistoryRepository>()),
    ]),
    filter: filter,
    navigator: Navigator.of(context),
  );
}
