import 'package:flutter/material.dart';
import 'package:places/ui/res/svg_icons/svg_icon.dart';
import 'package:places/ui/res/svg_icons/svg_icons.dart';
import 'package:places/ui/widgets/form_label.dart';

/// Текстовое поле с заголовком и кнопкой очистки
///
/// [labelText] - заголовок
///
/// кнопка "очистить" видна если в TextField есть контент и он в фокусе
/// [onSubmitted] вызывается когда пользователь закончил ввод
class TextFieldWithLabel extends StatefulWidget {
  final String text;
  final String labelText;
  final String hintText;
  final int maxLines;
  final FocusNode focusNode;

  final ValueChanged<String> onSubmitted;

  final TextEditingController controller;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;

  const TextFieldWithLabel({
    Key key,
    @required this.focusNode,
    @required this.controller,
    this.labelText,
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
  _TextFieldWithLabelState createState() => _TextFieldWithLabelState();
}

class _TextFieldWithLabelState extends State<TextFieldWithLabel> {
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
        child: Material(
          type: MaterialType.transparency,
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: SvgIcon(icon: SvgIcons.clear),
          ),
        ),
      ),
      suffixIconConstraints: BoxConstraints(),
    );

    final decoration = InputDecoration(
      hintText: widget.hintText,
      hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormLabel(text: widget.labelText),
        TextField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          decoration: _isClearVisible ? clearBtnDecoration : decoration,
          maxLines: widget.maxLines,
          textInputAction: widget.textInputAction,
          keyboardType: widget.keyboardType,
          onSubmitted: widget.onSubmitted,
          onChanged: (_) => _updateClearVisibility(),
        ),
      ],
    );
  }

  void _updateClearVisibility() {
    setState(() {
      _isClearVisible = widget.controller.text != '' && widget.focusNode.hasPrimaryFocus;
    });
  }

  void _onClearTap() {
    widget.controller.clear();
    _updateClearVisibility();
  }
}
