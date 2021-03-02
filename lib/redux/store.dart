import 'package:flutter/cupertino.dart';
import 'package:places/interactor/repository/location_repository.dart';
import 'package:places/interactor/repository/sight_repository.dart';
import 'package:places/interactor/search_history_interactor.dart';
import 'package:places/redux/middleware/search_middleware.dart';
import 'package:places/redux/reducer/search_reducer.dart';
import 'package:places/redux/state/search_state.dart';
import 'package:provider/provider.dart';
import 'package:redux/redux.dart';

/// Формирует стор для Redux
Store<SearchState> buildReduxStore(BuildContext context) {
  return Store<SearchState>(
    searchReducer,
    initialState: HistorySearchState(),
    middleware: [
      RequestSearchMiddleware(
        sightRepository: Provider.of<SightRepository>(context),
        locationRepository: Provider.of<LocationRepository>(context),
        historyInteractor: Provider.of<SearchHistoryInteractor>(context),
      ),
    ],
  );
}
