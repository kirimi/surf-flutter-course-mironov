import 'package:flutter/material.dart';
import 'package:places/ui/res/app_colors.dart';
import 'package:places/ui/res/app_text_styles.dart';

/// Виджет - элемент для [CustomTabBar].
///
/// Может быть в двух состояниях, что определяет свойство [isActive]
/// Можно кастомизировать цвета [bgrColor] [activeBgrColor]
/// и текстовые стили [style] [activeStyle]
class CustomTab extends StatelessWidget {
  final Color activeBgrColor;
  final Color bgrColor;
  final TextStyle activeStyle;
  final TextStyle style;
  final bool isActive;
  final String text;
  final VoidCallback onTap;

  const CustomTab({
    Key key,
    @required this.isActive,
    @required this.text,
    this.activeStyle = AppTextStyles.visitingActiveTab,
    this.style = AppTextStyles.visitingTab,
    this.activeBgrColor = AppColors.grayBlue,
    this.bgrColor = AppColors.transparent,
    this.onTap,
  })  : assert(isActive != null),
        assert(text != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap?.call(),
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            color: isActive ? activeBgrColor : bgrColor,
            borderRadius: BorderRadius.all(Radius.circular(40.0)),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: isActive ? activeStyle : style,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
