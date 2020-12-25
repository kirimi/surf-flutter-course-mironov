import 'package:flutter/material.dart';
import 'package:places/domain/sight_type.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_text_styles.dart';
import 'package:places/ui/res/svg_icons/svg_icon.dart';
import 'package:places/ui/res/svg_icons/svg_icons.dart';
import 'package:places/ui/widgets/form_label.dart';

/// Виджет - кнопка выбора категории.
///
/// Показывает выбранное значение [value]
/// или текст "Не выбрано", если [value] равно null
/// При тапе вызывается [onTap]
class CategorySelector extends StatelessWidget {
  final SightType value;
  final VoidCallback onTap;

  const CategorySelector({
    Key key,
    this.value,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String text = value?.name ?? AppStrings.addSightDoesNotSelected;
    final Color textColor = value != null ? Theme.of(context).primaryColor : Theme.of(context).disabledColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormLabel(
          text: AppStrings.addSightCategory,
          padding: const EdgeInsets.all(0),
        ),
        Material(
          child: InkWell(
            onTap: () {
              onTap?.call();
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 14.0, bottom: 14.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    text,
                    style: AppTextStyles.addSightCategory.copyWith(color: textColor),
                  ),
                  SvgIcon(icon: SvgIcons.arrowRight)
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
