import 'package:flutter/material.dart';
import 'package:places/ui/res/app_colors.dart';
import 'package:places/ui/res/svg_icons/svg_icon.dart';
import 'package:places/ui/res/svg_icons/svg_icons.dart';

/// Круглая кнопка с иконкой
class CircularIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final SvgData icon;

  const CircularIconButton({
    Key key,
    @required this.onPressed,
    @required this.icon,
  })  : assert(onPressed != null),
        assert(icon != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.0,
      width: 48.0,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.all(Radius.circular(24.0)),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(1, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(24.0)),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: onPressed,
            child: Center(
              child: SvgIcon(
                icon: icon,
                color: AppColors.black,
                size: 32.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
