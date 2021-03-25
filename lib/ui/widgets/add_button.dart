import 'package:flutter/material.dart';
import 'package:places/ui/res/app_colors.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_text_styles.dart';
import 'package:places/ui/res/svg_icons/svg_icon.dart';
import 'package:places/ui/res/svg_icons/svg_icons.dart';

/// Виджет рисует красивую кнопку добавления места
class AddButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddButton({
    Key key,
    @required this.onPressed,
  })  : assert(onPressed != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.0,
      width: 177.0,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(24.0)),
          gradient: LinearGradient(
            colors: [
              AppColors.yellow,
              Theme.of(context).accentColor,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(1, 3),
            ),
          ]),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(24.0)),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: onPressed,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SvgIcon(
                  icon: SvgIcons.plus,
                  color: AppColors.white,
                ),
                const SizedBox(width: 8.0),
                Text(
                  AppStrings.sightListAddBtn.toUpperCase(),
                  style: AppTextStyles.bigButtonText
                      .copyWith(color: AppColors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
