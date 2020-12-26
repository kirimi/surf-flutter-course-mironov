import 'package:flutter/material.dart';
import 'package:places/ui/res/svg_icons/svg_icon.dart';
import 'package:places/ui/res/svg_icons/svg_icons.dart';

/// Текстовое поле с кнопкой очистки
///
/// кнопка "очистить" видна если в TextField есть контент и он в фокусе
/// [onSubmitted] вызывается когда пользователь закончил ввод
class TextFieldWithClear extends StatefulWidget {
  final String text;
  final String hintText;
  final int maxLines;
  final FocusNode focusNode;

  final ValueChanged<String> onSubmitted;

  final TextEditingController controller;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;

  const TextFieldWithClear({
    Key key,
    @required this.focusNode,
    @required this.controller,
    this.onSubmitted,
    this.maxLines = 1,
    this.textInputAction,
    this.keyboardType,
    this.text,
    this.hintText,
  })  : assert(focusNode != null),
        assert(controller != null),
        super(key: key);

  @override
  _TextFieldWithClearState createState() => _TextFieldWithClearState();
}

class _TextFieldWithClearState extends State<TextFieldWithClear> {
  bool _isClearVisible;

  @override
  void initState() {
    super.initState();
    widget.controller.text = widget.text;
    _updateClearVisibility();
    widget.focusNode.addListener(_updateClearVisibility);
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_updateClearVisibility);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final clearBtnDecoration = InputDecoration(
      suffixIcon: InkWell(
        onTap: _onClearTap,
        child: const Material(
          type: MaterialType.transparency,
          child: Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: SvgIcon(icon: SvgIcons.clear),
          ),
        ),
      ),
      suffixIconConstraints: const BoxConstraints(),
    );

    final decoration = InputDecoration(
      hintText: widget.hintText,
      hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
    );

    return TextField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      decoration: _isClearVisible ? clearBtnDecoration : decoration,
      maxLines: widget.maxLines,
      textInputAction: widget.textInputAction,
      keyboardType: widget.keyboardType,
      onSubmitted: widget.onSubmitted,
      onChanged: (_) => _updateClearVisibility(),
    );
  }

  void _updateClearVisibility() {
    setState(() {
      _isClearVisible =
          widget.controller.text != '' && widget.focusNode.hasPrimaryFocus;
    });
  }

  void _onClearTap() {
    widget.controller.clear();
    _updateClearVisibility();
  }
}
