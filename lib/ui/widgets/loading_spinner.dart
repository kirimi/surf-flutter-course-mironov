import 'package:flutter/material.dart';

/// Анимированный спиннер загрузки
class LoadingSpinner extends StatefulWidget {
  const LoadingSpinner({Key key}) : super(key: key);
  @override
  _LoadingSpinnerState createState() => _LoadingSpinnerState();
}

class _LoadingSpinnerState extends State<LoadingSpinner>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animationRotation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animationRotation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(_animationController);
    _animationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _animationRotation,
      child: Image.asset('res/images/loading.png'),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
