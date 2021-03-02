import 'package:places/redux/action/search_action.dart';
import 'package:places/redux/state/search_state.dart';
import 'package:redux/redux.dart';

/// Редьюсеры
final searchReducer = combineReducers<SearchState>([
  TypedReducer<SearchState, OnLoadingSearchAction>(_onLoading),
  TypedReducer<SearchState, OnResultSearchAction>(_onResult),
  TypedReducer<SearchState, HistorySearchAction>(_onHistory),
  TypedReducer<SearchState, OnErrorSearchAction>(_onError),
]);

SearchState _onLoading(SearchState state, OnLoadingSearchAction action) =>
    LoadingSearchState();

SearchState _onResult(SearchState state, OnResultSearchAction action) =>
    ResultSearchState(action.sights);

SearchState _onHistory(SearchState state, HistorySearchAction action) =>
    HistorySearchState();

SearchState _onError(SearchState state, OnErrorSearchAction action) =>
    ErrorSearchState(action.message);
