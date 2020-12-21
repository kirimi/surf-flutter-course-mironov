import 'package:flutter/material.dart';

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
    final List<Widget> childrenWithSpacing = [];
    for (var i = 0; i < children.length; i++) {
      childrenWithSpacing.add(children[i]);
      if (i != children.length - 1) {
        childrenWithSpacing.add(
          const SizedBox(height: spaceHeight),
        );
      }
    }

    return SingleChildScrollView(
      child: Padding(
        padding: padding,
        child: Column(
          children: childrenWithSpacing,
        ),
      ),
    );
  }
}
