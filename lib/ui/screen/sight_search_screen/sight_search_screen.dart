import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:places/domain/filter.dart';
import 'package:places/domain/sight.dart';
import 'package:places/redux/action/search_action.dart';
import 'package:places/redux/state/search_state.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/svg_icons/svg_icon.dart';
import 'package:places/ui/res/svg_icons/svg_icons.dart';
import 'package:places/ui/screen/sight_details_screen/sight_details_bottomsheet.dart';
import 'package:places/ui/screen/sight_search_screen/widget/history_list.dart';
import 'package:places/ui/screen/sight_search_screen/widget/search_result_item.dart';
import 'package:places/ui/widgets/center_message.dart';
import 'package:places/ui/widgets/search_bar.dart';
import 'package:redux/redux.dart';

/// Экран поиска места
///
/// В конструкторе передается текущий фильтр
class SightSearchScreen extends StatefulWidget {
  static const String routeName = 'SightSearchScreen';

  final Filter filter;

  const SightSearchScreen({
    Key key,
    @required this.filter,
  })  : assert(filter != null),
        super(key: key);

  @override
  _SightSearchScreenState createState() => _SightSearchScreenState();
}

class _SightSearchScreenState extends State<SightSearchScreen> {
  TextEditingController _textEditingController;
  Store<SearchState> _store;

  @override
  void initState() {
    super.initState();
    _store = StoreProvider.of<SearchState>(context);
    _textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.sightSearchAppBar),
        leading: IconButton(
          onPressed: _onBack,
          icon: SvgIcon(
            icon: SvgIcons.arrowLeft,
            color: Theme.of(context).primaryColor,
          ),
        ),
        bottom: SearchBar(
          controller: _textEditingController,
          onChanged: _onSearch,
          onClear: _onClear,
        ),
      ),
      body: StoreConnector<SearchState, SearchState>(
        onInit: (store) {
          store.dispatch(HistorySearchAction());
        },
        converter: (store) {
          return store.state;
        },
        builder: (context, state) {
          if (state is LoadingSearchState) {
            return _buildLoading();
          } else if (state is ResultSearchState) {
            if (state.sights.isEmpty) {
              return _buildEmpty();
            } else {
              return _buildResultList(state.sights);
            }
          } else if (state is ErrorSearchState) {
            return _buildError();
          } else {
            return _buildHistory();
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  Widget _buildResultList(List<Sight> sights) {
    return ListView.builder(
      itemCount: sights.length,
      itemBuilder: (context, index) {
        return SearchResultItem(
          sight: sights[index],
          onTap: () => _onCardTap(sights[index]),
        );
      },
    );
  }

  Widget _buildHistory() {
    return HistoryList(
      onSelect: (request) {
        _textEditingController.text = request;
        _onSearch(request, performNow: true);
      },
    );
  }

  Widget _buildError() {
    return const CenterMessage(
      icon: SvgIcons.error,
      title: AppStrings.sightSearchErrorTitle,
      subtitle: AppStrings.sightSearchErrorSubtitle,
    );
  }

  Widget _buildEmpty() {
    return const CenterMessage(
      icon: SvgIcons.search,
      title: AppStrings.sightSearchEmptyTitle,
      subtitle: AppStrings.sightSearchEmptySubtitle,
    );
  }

  Widget _buildLoading() {
    return const SizedBox(
      height: 40.0,
      width: 40.0,
      child: CircularProgressIndicator(),
    );
  }

  // performNow - флаг, что запрос должен немедленно выполнится.
  // Например при книке на Историю
  void _onSearch(String value, {bool performNow = false}) {
    _store.dispatch(
      RequestSearchAction(
        value,
        filter: widget.filter,
        performNow: performNow,
      ),
    );
  }

  void _onCardTap(Sight sight) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) {
          return SightDetailsBottomSheet(sight: sight);
        });
  }

  // при очистке текстового поля показываем историю
  void _onClear() => _store.dispatch(HistorySearchAction());

  void _onBack() => Navigator.of(context).pop();
}
