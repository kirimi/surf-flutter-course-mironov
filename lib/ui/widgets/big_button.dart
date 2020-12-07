import 'package:flutter/material.dart';
import 'package:places/ui/res/app_colors.dart';
import 'package:places/ui/res/app_text_styles.dart';

class BigButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color bgColor;
  final Color color;
  final Color disabledColor;
  final Color disabledBgColor;
  final TextStyle style;
  final bool enabled;
  final VoidCallback onPressed;

  const BigButton({
    Key key,
    @required this.text,
    @required this.onPressed,
    this.icon,
    this.color = AppColors.white,
    this.disabledColor = AppColors.black54,
    this.bgColor = AppColors.green,
    this.disabledBgColor = AppColors.grey,
    this.style = AppTextStyles.bigButtonText,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onPressed : null,
      child: Container(
        height: 48.0,
        decoration: BoxDecoration(
          color: enabled ? bgColor : disabledBgColor,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                color: enabled ? color : disabledColor,
              ),
              SizedBox(width: 10),
            ],
            Text(
              text,
              style: style.copyWith(color: enabled ? color : disabledColor),
            ),
          ],
        ),
      ),
    );
  }
}
