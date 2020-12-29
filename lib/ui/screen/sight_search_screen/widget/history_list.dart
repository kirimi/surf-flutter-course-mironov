import 'package:flutter/material.dart';
import 'package:places/search_history_state.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_text_styles.dart';
import 'package:places/ui/res/svg_icons/svg_icon.dart';
import 'package:places/ui/res/svg_icons/svg_icons.dart';
import 'package:places/ui/widgets/label.dart';

/// Виджет выводит список истории поиска
///
/// [onSelect] при выборе элемента для поиска
class HistoryList extends StatefulWidget {
  final SearchHistoryState searchHistoryState;
  final ValueChanged<String> onSelect;

  const HistoryList({
    Key key,
    @required this.onSelect,
    @required this.searchHistoryState,
  })  : assert(onSelect != null),
        assert(searchHistoryState != null),
        super(key: key);

  @override
  _HistoryListState createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  List<String> _list;

  @override
  void initState() {
    super.initState();
    _list = widget.searchHistoryState.list;
  }

  @override
  Widget build(BuildContext context) {
    if (_list.isEmpty) {
      return Container();
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Label(text: AppStrings.searchHistoryTitle),
            ListView.separated(
              itemCount: _list.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return _HistoryItem(
                  title: _list[index],
                  onTap: () => widget.onSelect(_list[index]),
                  onDelete: () => _onDeleteItem(index),
                );
              },
              separatorBuilder: (context, index) => const Divider(),
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
    widget.searchHistoryState.remove(index);
    setState(() {
      _list = widget.searchHistoryState.list;
    });
  }

  void _onClearHistory() {
    widget.searchHistoryState.clear();
    setState(() {
      _list = widget.searchHistoryState.list;
    });
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
