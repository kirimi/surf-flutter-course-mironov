import 'package:flutter/material.dart';
import 'package:places/ui/res/svg_icons/svg_icon.dart';
import 'package:places/ui/res/svg_icons/svg_icons.dart';

/// Элемент истории с кнопкой удаления
/// при клике на элементе вызывается [onTap]
/// при клике на удалить [onDelete]
class HistoryItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const HistoryItem({
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
