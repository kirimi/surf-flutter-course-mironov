import 'package:flutter/material.dart';
import 'package:places/ui/res/svg_icons/svg_icon.dart';
import 'package:places/ui/screen/onboarding_screen/model/onboarding_item.dart';

/// Рисует центральный элемент на странице онбординга
class OnboardingContent extends StatefulWidget {
  final OnboardingItem item;
  final AnimationController animationController;

  const OnboardingContent({
    Key key,
    @required this.item,
    @required this.animationController,
  })  : assert(item != null),
        super(key: key);

  @override
  _OnboardingContentState createState() => _OnboardingContentState();
}

class _OnboardingContentState extends State<OnboardingContent> {
  Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();
    _sizeAnimation = Tween<double>(begin: 10.0, end: 104.0)
        .animate(widget.animationController);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(58.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 104.0,
            child: AnimatedBuilder(
              animation: widget.animationController,
              builder: (context, _) {
                return SvgIcon(
                  icon: widget.item.icon,
                  size: _sizeAnimation.value,
                );
              },
            ),
          ),
          const SizedBox(height: 40.0),
          Text(
            widget.item.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline5,
          ),
          const SizedBox(height: 8.0),
          Text(
            widget.item.subTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
    );
  }
}
