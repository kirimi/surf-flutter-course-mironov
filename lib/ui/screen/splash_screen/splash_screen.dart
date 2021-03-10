import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/ui/res/app_colors.dart';
import 'package:places/ui/res/svg_icons/svg_icon.dart';
import 'package:places/ui/res/svg_icons/svg_icons.dart';
import 'package:places/ui/screen/splash_screen/splash_wm.dart';
import 'package:provider/provider.dart';

/// Сплэш-экран
///
/// Вызывает и ждет инициализацию приложения. Ждет 2 секунды,
/// если инициализация закончилась раньше.
/// Далее автоматический переход на OnBoardingScreen или SightListScreen
/// в зависимости от того, первый раз открыли приложение или нет.
class SplashScreen extends CoreMwwmWidget {
  static const String routeName = 'SplashScreen';

  SplashScreen()
      : super(
          widgetModelBuilder: (context) => SplashWm(
            context.read<WidgetModelDependencies>(),
            navigator: Navigator.of(context),
          ),
        );

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends WidgetState<SplashWm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.yellow,
              Theme.of(context).accentColor,
            ],
          ),
        ),
        child: Center(
          child: AnimatedBuilder(
            animation: wm.rotationAnimation,
            builder: (context, _) {
              return Transform.rotate(
                angle: wm.rotationAnimation.value,
                child: const SvgIcon(
                  icon: SvgIcons.logo,
                  size: 160,
                  color: AppColors.white,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
