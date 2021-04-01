import 'package:flutter/material.dart';
import 'package:places/environment/environment.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_text_styles.dart';

/// Заголовок страницы.  Меняет размер шрифта в соответствии с высотой.
/// Слова переносятся автоматически.
class SearchSliverPersistentHeaderDelegate
    extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final textSizeTween = Tween<double>(begin: 32, end: 18).chain(
      CurveTween(curve: Curves.easeOutCubic),
    );
    final progress = shrinkOffset / maxExtent;
    final fontSize = textSizeTween.transform(progress);

    final debugText = Environment.instance.buildConfig.debugTitle;
    final appBarText = '${AppStrings.sightListAppBar} $debugText';

    return Container(
      color: Theme.of(context).backgroundColor,
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            // ограничиваем ширину в 300,
            // чтобы перенос слов при скролле был более адекватен
            width: 300,
            child: Text(
              appBarText,
              style: AppTextStyles.appBarTitle.copyWith(
                fontSize: fontSize,
                height: 1.2,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 150;

  @override
  double get minExtent => 70;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
