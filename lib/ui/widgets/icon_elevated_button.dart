import 'package:flutter/material.dart';

/// Виджет рисует кнопку ElevatedButton с иконкой и текстом по центру
///
/// все параметры опциональны
class IconElevatedButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  const IconElevatedButton({
    Key key,
    this.text,
    this.icon,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> content = [];

    if (icon != null) {
      content.add(
        Icon(icon),
      );
    }

    if (icon != null && text != null) {
      content.add(const SizedBox(width: 10));
    }

    if (text != null) {
      content.add(Text(text));
    }

    return ElevatedButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: content,
      ),
      onPressed: onPressed,
    );
  }
}
