import 'package:flutter/material.dart';

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
    this.color = Colors.white,
    this.disabledColor = Colors.black54,
    this.bgColor = Colors.green,
    this.disabledBgColor = Colors.grey,
    this.style = _textStyle,
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

const _textStyle = TextStyle(
  color: Color(0xFF3B3E5B),
  fontWeight: FontWeight.w700,
  fontSize: 14.0,
  letterSpacing: 0.3,
  height: 18.0 / 14.0,
);
