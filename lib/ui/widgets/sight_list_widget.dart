import 'package:flutter/material.dart';
import 'package:places/main.dart';

/// Виджет выводит список виджетов [children] со скроллом.
///
/// между элементами списка вставляется разрыв 16dp
class SightListWidget extends StatelessWidget {
  static const spaceHeight = 16.0;

  final List<Widget> children;
  final EdgeInsetsGeometry padding;

  const SightListWidget({
    Key key,
    @required this.children,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0),
  })  : assert(children != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: scrollPhysics,
      padding: padding,
      itemCount: children.length,
      itemBuilder: (context, index) => children[index],
      separatorBuilder: (context, index) => const SizedBox(height: spaceHeight),
    );
  }
}
