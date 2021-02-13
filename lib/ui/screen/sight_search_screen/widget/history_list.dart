import 'dart:async';

import 'package:flutter/material.dart';
import 'package:places/interactor/search_history_interactor.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_text_styles.dart';
import 'package:places/ui/res/svg_icons/svg_icon.dart';
import 'package:places/ui/res/svg_icons/svg_icons.dart';
import 'package:places/ui/widgets/label.dart';
import 'package:provider/provider.dart';

/// Виджет выводит список истории поиска
///
/// [onSelect] при выборе элемента для поиска
class HistoryList extends StatefulWidget {
  final ValueChanged<String> onSelect;

  const HistoryList({
    Key key,
    @required this.onSelect,
  })  : assert(onSelect != null),
        super(key: key);

  @override
  _HistoryListState createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  @override
  void initState() {
    super.initState();

    // Начальное значение для стрима
    scheduleMicrotask(() {
      context.read<SearchHistoryInteractor>().fetchRequests();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Label(text: AppStrings.searchHistoryTitle),
            StreamBuilder<List<String>>(
              stream:
                  context.read<SearchHistoryInteractor>().requestsListStream,
              builder: (context, snapshot) {
                if (snapshot.hasError || !snapshot.hasData) {
                  return const SizedBox.shrink();
                }

                final list = snapshot.data;

                return ListView.separated(
                  itemCount: list.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return _HistoryItem(
                      title: list[index],
                      onTap: () => widget.onSelect(list[index]),
                      onDelete: () => _onDeleteItem(index),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                );
              },
            ),
            TextButton(
              onPressed: _onClearHistory,
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

  void _onDeleteItem(int index) {
    context.read<SearchHistoryInteractor>().remove(index);
  }

  void _onClearHistory() {
    context.read<SearchHistoryInteractor>().clear();
  }
}

/// Элемент истории с кнопкой удаления
/// при клике на элементе вызывается [onTap]
/// при клике на удалить [onDelete]
class _HistoryItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _HistoryItem({
    Key key,
    @required this.title,
    @required this.onTap,
    @required this.onDelete,
  })  : assert(title != null),
        assert(onTap != null),
        assert(onDelete != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: IconButton(
        icon: const SvgIcon(icon: SvgIcons.delete),
        onPressed: onDelete,
      ),
      onTap: onTap,
    );
  }
}
