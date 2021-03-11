import 'package:flutter/material.dart';
import 'package:places/ui/res/app_colors.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_text_styles.dart';

/// Виджет - таббар для страницы VisitingScreen
class VisitingTabBar extends StatefulWidget implements PreferredSizeWidget {
  static const _tabBarHeight = 52.0;

  final TabController controller;
  final VoidCallback onTap;

  const VisitingTabBar({
    Key key,
    @required this.controller,
    this.onTap,
  })  : assert(controller != null),
        super(key: key);

  @override
  _VisitingTabBarState createState() => _VisitingTabBarState();

  @override
  Size get preferredSize => const Size.fromHeight(VisitingTabBar._tabBarHeight);
}

class _VisitingTabBarState extends State<VisitingTabBar> {
  Animation<double> animation;
  Animation<AlignmentGeometry> alignAnimation;

  @override
  void initState() {
    super.initState();
    animation = widget.controller.animation;

    alignAnimation = AlignmentTween(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ).animate(animation);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      child: GestureDetector(
        onTap: () => widget.onTap?.call(),
        child: Container(
          height: VisitingTabBar._tabBarHeight,
          decoration: BoxDecoration(
            color: AppColors.grayF5,
            borderRadius:
                BorderRadius.circular(VisitingTabBar._tabBarHeight / 2),
          ),
          child: AnimatedBuilder(
            animation: animation,
            builder: (context, _) {
              return Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _InactiveTab(
                        text: AppStrings.visitingWantToVisitTab,
                        animationValue: animation.value,
                      ),
                      _InactiveTab(
                        text: AppStrings.visitingVisitedTab,
                        animationValue: 1 - animation.value,
                      ),
                    ],
                  ),
                  Align(
                    alignment: alignAnimation.value,
                    child: LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                        return ConstrainedBox(
                          constraints: constraints.copyWith(
                            maxWidth: constraints.maxWidth / 2,
                          ),
                          child: _ActiveTab(
                            animationValue: animation.value,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

/// Неактивный таб
class _InactiveTab extends StatelessWidget {
  final String text;
  final double animationValue;

  const _InactiveTab({Key key, this.animationValue, this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Opacity(
          opacity: animationValue,
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.visitingTab.copyWith(
              color: Theme.of(context).disabledColor,
            ),
          ),
        ),
      ),
    );
  }
}

/// Активный таб
class _ActiveTab extends StatelessWidget {
  final double animationValue;

  const _ActiveTab({Key key, this.animationValue}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.grayBlue,
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Stack(
            children: [
              Opacity(
                opacity: animationValue,
                child: Text(
                  AppStrings.visitingVisitedTab,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.visitingActiveTab
                      .copyWith(color: Colors.white),
                ),
              ),
              Opacity(
                opacity: 1 - animationValue,
                child: Text(
                  AppStrings.visitingWantToVisitTab,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.visitingActiveTab
                      .copyWith(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
