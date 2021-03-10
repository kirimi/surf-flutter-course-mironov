import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/data/search_history_repository/search_history_repository.dart';
import 'package:places/model/search_history/performers.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_text_styles.dart';
import 'package:places/ui/res/svg_icons/svg_icons.dart';
import 'package:places/ui/screen/sight_search_screen/history/history_item.dart';
import 'package:places/ui/screen/sight_search_screen/history/history_wm.dart';
import 'package:places/ui/widgets/center_message.dart';
import 'package:places/ui/widgets/label.dart';
import 'package:provider/provider.dart';
import 'package:relation/relation.dart';

/// Виджет выводит список истории поиска
///
/// [onSelect] при выборе элемента для поиска
class HistoryList extends CoreMwwmWidget {
  HistoryList({@required ValueChanged<String> onSelect})
      : assert(onSelect != null),
        super(
          widgetModelBuilder: (context) => HistoryWm(
            context.read<WidgetModelDependencies>(),
            Model([
              AddToHistoryPerformer(context.read<SearchHistoryRepository>()),
              RemoveFromHistoryPerformer(
                  context.read<SearchHistoryRepository>()),
              ClearHistoryPerformer(context.read<SearchHistoryRepository>()),
              GetHistoryPerformer(context.read<SearchHistoryRepository>()),
            ]),
            onSelect: onSelect,
          ),
        );

  @override
  _HistoryListState createState() => _HistoryListState();
}

class _HistoryListState extends WidgetState<HistoryWm> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Label(text: AppStrings.searchHistoryTitle),
            EntityStateBuilder<List<String>>(
              streamedState: wm.history,
              child: (context, data) {
                return ListView.separated(
                  itemCount: data.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return HistoryItem(
                      title: data[index],
                      onTap: () => wm.onSelect(data[index]),
                      onDelete: () => wm.removeFromHistory(data[index]),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                );
              },
              loadingChild: _buildLoading(),
              errorChild: _buildError(),
            ),
            TextButton(
              onPressed: wm.clearHistory,
              child: Text(
                AppStrings.searchClearHistory,
                style: AppTextStyles.appBarButton.copyWith(
                  color: Theme.of(context).accentColor,
                ),
              ),
            )
          ],
        ),
      ),
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

  Widget _buildError() {
    return const CenterMessage(
      icon: SvgIcons.error,
      title: AppStrings.historyErrorTitle,
      subtitle: AppStrings.historyErrorSubtitle,
    );
  }
}
