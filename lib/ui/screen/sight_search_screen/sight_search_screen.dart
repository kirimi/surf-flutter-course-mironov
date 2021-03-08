import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/svg_icons/svg_icon.dart';
import 'package:places/ui/res/svg_icons/svg_icons.dart';
import 'package:places/ui/screen/sight_details_screen/sight_details_bottomsheet.dart';
import 'package:places/ui/screen/sight_search_screen/history/history_list.dart';
import 'package:places/ui/screen/sight_search_screen/sight_search_wm.dart';
import 'package:places/ui/screen/sight_search_screen/widget/search_result_item.dart';
import 'package:places/ui/widgets/center_message.dart';
import 'package:places/ui/widgets/search_bar.dart';
import 'package:relation/relation.dart';

/// Экран поиска места
class SightSearchScreen extends CoreMwwmWidget {
  static const String routeName = 'SightSearchScreen';

  const SightSearchScreen({
    @required WidgetModelBuilder wmBuilder,
  })  : assert(wmBuilder != null),
        super(widgetModelBuilder: wmBuilder);

  @override
  _SightSearchScreenState createState() => _SightSearchScreenState();
}

class _SightSearchScreenState extends WidgetState<SightSearchWm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.sightSearchAppBar),
        leading: IconButton(
          onPressed: wm.onBack,
          icon: SvgIcon(
            icon: SvgIcons.arrowLeft,
            color: Theme.of(context).primaryColor,
          ),
        ),
        bottom: SearchBar(
          controller: wm.searchText.controller,
          onChanged: _onSearch,
          onClear: _onClear,
        ),
      ),
      body: StreamedStateBuilder<bool>(
        streamedState: wm.historyShow,
        builder: (context, isHistoryShow) {
          if (isHistoryShow) {
            return _buildHistory();
          } else {
            return EntityStateBuilder<List<Sight>>(
              streamedState: wm.searchResult,
              child: (context, sights) =>
                  sights.isEmpty ? _buildEmpty() : _buildResultList(sights),
              loadingBuilder: (context, _) => _buildLoading(),
              errorBuilder: (context, _, e) => _buildError(),
            );
          }
        },
      ),
    );
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
        wm.searchText.controller.text = request;
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
    return const Center(
      child: SizedBox(
        height: 40.0,
        width: 40.0,
        child: CircularProgressIndicator(),
      ),
    );
  }

  // performNow - флаг, что запрос должен немедленно выполнится.
  // Например при книке на Историю
  void _onSearch(String term, {bool performNow = false}) =>
      wm.search(SearchRequest(term, performNow: performNow));

  void _onCardTap(Sight sight) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) {
          return SightDetailsBottomSheet(sight: sight);
        });
  }

  // при очистке текстового поля показываем историю
  void _onClear() => wm.clearSearch();
}
